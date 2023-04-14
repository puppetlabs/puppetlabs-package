# $1 = string literal to feed to pkg-query. include json formatting
# No error check here because querying the status of uninstalled packages will return non-zero
# Use the format string to make a json object with status and version
# This will print nothing to stdout if the package is not installed
pkg_status() {
  pkg query "$1" "${name}"
}

# Determine if newer package is available to mirror the ruby/puppet implementation
pkg_check_latest() {
  installed="$(pkg_status '%v')"
  [ -z "$installed" ] && success '{ "status": "uninstalled", "version": ""}'

  candidate=$(pkg rquery '%v' "$name")

  if [ "$installed" != "$candidate" ]; then
    cmd_status="{ \"status\":\"installed\", \"version\":\"${installed}\", \"latest\":\"${candidate}\" }"
  else
    cmd_status="$(pkg_status '{ "status":"installed", "version":"%v" }')"
  fi

  success "$cmd_status"
}
