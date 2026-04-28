# CLAUDE.md

## Project Overview

This is `puppetlabs-package` — a Puppet module (v3.1.0) that provides Bolt/PE tasks for installing, uninstalling, updating, and checking the status of packages across Linux and Windows systems.

## Structure

- `tasks/` — Bolt task entry points (`init.rb` for cross-platform, `linux.sh`, `windows.ps1`)
- `tasks/*.json` — Task metadata definitions
- `files/` — Shell helpers sourced by the Linux task (`apt.sh`, `yum.sh`, `zypper.sh`, `pkg.sh`, `common.sh`)
- `data/` — Hiera data (`common.yaml`)
- `spec/` — Tests (RSpec + acceptance tests via puppet_litmus)
- `metadata.json` — Module metadata, supported OS list, Puppet version requirement (`>= 8.0.0 < 9.0.0`)

## Development

### Dependencies

```sh
bundle install
```

Set `PUPPET_GEM_VERSION` and `FACTER_GEM_VERSION` env vars to pin specific versions. Set `PUPPET_FORGE_TOKEN` for authenticated gem sources.

### Running Tests

```sh
# Unit/spec tests
bundle exec rake spec

# Linting
bundle exec rake lint

# Syntax checks
bundle exec rake syntax

# RuboCop
bundle exec rubocop
```

### Acceptance Tests

Uses [puppet_litmus](https://github.com/puppetlabs/puppet_litmus). See `spec/acceptance/` for test files and `provision.yaml` for provisioning config.

### Code Style

- Ruby target: 3.1 (`.rubocop.yml`)
- RuboCop with `rubocop-performance` and `rubocop-rspec` extensions
- Line length max: 200
- snake_case naming convention
- Prefer `%r{}` for regex literals
- Trailing commas on multiline arrays/arguments
- Bracket-style symbol/word arrays (`[:foo, :bar]` not `%i[foo bar]`)

### CI

GitHub Actions workflows in `.github/workflows/`:
- `ci.yml` — Spec + acceptance on PRs to `main`
- `nightly.yml` — Nightly runs
- `release.yml` / `release_prep.yml` — Release automation
- Uses shared workflows from `puppetlabs/cat-github-actions`

## Key Conventions

- PDK-managed module (template from `pdk-templates`)
- Apache-2.0 license
- No Puppet classes/manifests — this is a tasks-only module
- Puppet-lint configured via `.puppet-lint.rc` and `Rakefile` (several checks disabled)

## Rules

- At the start of a coding session, review the repository structure and any relevant README or documentation files to understand the area you are working in.
- Always read the files relevant to the task before suggesting or making a change.
- Never merge a pull request.
- Never work directly on the main or master branch.
- Never push a branch without explicit instruction.
- Never delete a file without permission — this applies even after a blanket "yes to all".
- Never output, log, save, or hardcode security-sensitive values — this includes passwords, tokens, API keys, private keys, secrets, and credentials of any kind. Do not write them to files, include them in commit messages, or print them in responses.
