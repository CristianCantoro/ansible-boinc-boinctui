#!/usr/bin/env bash

# shellcheck disable=SC2128
SOURCED=false && [ "$0" = "$BASH_SOURCE" ] || SOURCED=true

if ! $SOURCED; then
  set -euo pipefail
  IFS=$'\n\t'
fi

usage() {
  echo \
"Usage:
  deploy_boinc_server.sh [args]
  deploy_boinc_server.sh -h

Deploy a BOINC server.

Options:
  [args]      Pass all the arguments to the ansible-playbook.
  -h          Show this help and exits.

Example:
  deploy_boinc_server.sh"
}

flag_help=false
while getopts ":h" opt; do
  case $opt in
    h)
      flag_help=true
      ;;
    :)
      (>&2 echo "Option -$OPTARG requires an argument.")
      exit 1
      ;;
    *)
      true
      ;;
  esac
done

if $flag_help; then
  usage
  exit 0
fi

# store arguments in a special array
declare -a args
args=( "$@" )

# get number of elements
# nargs="${#args[@]}"

set -x
# shellcheck disable=SC2086
ansible-playbook -v -i inventories/production/hosts "${args[@]:-}" \
  install_boinc.yml

exit 0
