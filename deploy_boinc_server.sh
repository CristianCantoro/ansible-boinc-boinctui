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
  deploy_boinc_server.sh [options] [<ssh_port>]

Deploy a BOINC server.

Options:
  -h              Show this help and exits.
  -s <ssh_port>   Value of the option ssh_server_ports

Example:
  deploy_boinc_server.sh"
}

flag_help=false
ssh_port='0'
while getopts ":hs:" opt; do
  case $opt in
    h)
      flag_help=true
      ;;
    s)
      ssh_port="$OPTARG"

      int_regex='^[0-9]+$'
      if ! [[ "$ssh_port" =~ $int_regex ]] ; then
        (>&2 echo "Error: option -s needs a number, got $ssh_port instead.")
        exit 1
      elif ! [[ "$ssh_port" -gt 0  && "$ssh_port" -le 65536 ]]; then
        (>&2 echo "Error: option -s is for an ssh_port 0 < ssh_port < 65536.")
        exit 1
      fi
      ;;
    \?)
      (>&2 echo "Invalid option: -$OPTARG")
      ;;
    :)
      (>&2 echo "Option -$OPTARG requires an argument.")
      exit 1
      ;;
  esac
done

if $flag_help; then
  usage
  exit 0
fi

options=()
if [[ "$ssh_port" -gt 0 ]]; then
  options=(--extra-vars "{'ssh_server_ports': [$ssh_port]}")
fi

set -x
# shellcheck disable=SC2086
ansible-playbook -v \
                 -i inventories/production/hosts \
                 ${options[*]:-} \
                    install_boinc.yml
