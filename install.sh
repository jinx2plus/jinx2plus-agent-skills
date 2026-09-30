#!/usr/bin/env sh
set -eu

agent=${1:-}
force=${2:-}

case "$agent" in
  codex) destination="${HOME}/.codex/skills" ;;
  gajae) destination="${HOME}/.gjc/agent/skills" ;;
  *) echo "usage: ./install.sh <codex|gajae> [--force]" >&2; exit 2 ;;
esac

case "$force" in
  ""|--force) ;;
  *) echo "usage: ./install.sh <codex|gajae> [--force]" >&2; exit 2 ;;
esac

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
mkdir -p "$destination"

for skill in "$root"/skills/*; do
  name=$(basename "$skill")
  target="$destination/$name"
  if [ -e "$target" ] && [ "$force" != "--force" ]; then
    echo "exists: $target (rerun with --force to replace)" >&2
    exit 1
  fi
  rm -rf "$target"
  cp -R "$skill" "$target"
  echo "installed: $target"
done
