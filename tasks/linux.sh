#!/bin/bash

# example cli /opt/puppetlabs/puppet/bin/bolt task run package::linux action=install name=vim --nodes localhost --modulepath /et c/puppetlabs/code/modules --password puppet --user root

# Exit with an error message and error code, defaulting to 1
fail() {
  # Print a message: entry if there were anything printed to stderr
  if [[ -s $_tmp ]]; then
    # Hack to try and output valid json by replacing newlines with spaces.
    echo "{ \"status\": \"error\", \"message\": \"$(tr '\n' ' ' <$_tmp)\" }"
  else
    echo '{ "status": "error" }'
  fi

  exit ${2:-1}
}

success() {
  echo "$1"
  exit 0
}

# Keep stderr in a temp file.  Easier than `tee` or capturing process substitutions
_tmp="$(mktemp)"
exec 2>"$_tmp"

action="$PT_action"
name="$PT_name"
version="$PT_version"
package_managers=("apt-get" "yum")
options=()

for p in "${package_managers[@]}"; do
  if type "$p" &>/dev/null; then
    available_manager="$p"
    break
  fi
done

[[ $available_manager ]] || {
  echo '{ "status": "error", "message": "No package managers found", "message": "Must be one of: [apt, yum]" }'
  exit 255
}

# For any package manager, check if the action is "status". If so, only run a status command
# Otherwise, run the requested action and follow up with a "status" command
case "$available_manager" in
  "apt-get")
    # quiet and assume yes
    options+=("-yq")

    # <package>=<version> is the syntax for installing a specific version in apt
    [[ $version ]] && name="${name}=${version}"

    case "$action" in
      "uninstall")
        action="remove"
        ;;
      "upgrade")
        action="install"
        options+=("--only-upgrade")
    esac

    [[ $action == "status" ]] || DEBIAN_FRONTEND=noninteractive "apt-get" "$action" "$name" "${options[@]}" >/dev/null || fail

    # Use --showformat to make a json object with status and version
    # ${name%%=*} removes the version in case we installed a specific one
    # This will print nothing to stdout if the package is not installed
    cmd_status="$(dpkg-query --show --showformat='{ "status": "success", "package_status":"${Status}", "version":"${Version}" }' ${name%%=*})"
    [[ $cmd_status ]] || cmd_status='{ "status": "uninstalled" }'
    success "$cmd_status"
    ;;

  "yum")
    # assume yes
    options+=("-y")

    # <package>-<version> is the syntax for installing a specific version in yum
    [[ $version ]] && name="${name}-${version}"

    case "$action" in
      "uninstall")
        action="remove"
    esac

    [[ $action == "status" ]] || "yum" "$action" "$name" "${options[@]}" >/dev/null || fail

    # yum install <pkg> and rpm -q <pkg> may produce different results because one package may provide another
    # For example, 'vim' can be installed because the 'vim-enhanced' package provides 'vim'
    # So, find out the exact package to get the status for
    #TODO: can this return multiple results?
    package="$(rpm -q --whatprovides "$name")"

    # Use --queryformat to make a json object with status and version
    # yum is ok with including the version in the package name
    # yum returns non-zero if the package isn't installed
    cmd_status="$(rpm -q --queryformat '\{ "status": "success", "package_status": "installed", "version": "%{VERSION}" \}' "$package")" || {
       cmd_status='{ "status": "success", "package_status": "uninstalled" }'
    }
    success "$cmd_status"
esac
