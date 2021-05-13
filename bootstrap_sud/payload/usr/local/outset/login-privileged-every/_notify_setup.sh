#!/bin/bash

hubcli="/usr/local/bin/hubcli"
rm="/bin/rm"
pgrep="/usr/bin/pgrep"
sleep="/bin/sleep"

dock_status=$(${pgrep} -x Dock)
while [ "${dock_status}" == "" ]; do
  ${sleep} 2
  dock_status=$(${pgrep} -x Dock)
done

${sleep} 2

${hubcli} notify --title "macOS Setup" --info "Welcome! Your computer is finishing up now." --actionbtn "Open MSC" --script "/usr/bin/open munki://updates"

${rm} -- "$0"

exit 0
