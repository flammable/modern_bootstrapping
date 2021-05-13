#!/bin/bash

authchanger="/usr/local/bin/authchanger"
defaults="/usr/bin/defaults"
echo="/bin/echo"
killall="/usr/bin/killall"
touch="/usr/bin/touch"

# Location of DEPNotify's registration plist
registration_plist="/Users/Shared/UserInput.plist"

# Read the computer type from DEPNotify's registration plist
computer_type=$(${defaults} read ${registration_plist} "Computer Type")

# Set location of Munki bootstrap file
munki_bootstrap="/Users/Shared/.com.googlecode.munki.checkandinstallatstartup"

# Set DEPNotify log location
depnotify_log="/var/tmp/depnotify.log"

# General Use
if [[ ${computer_type} == 'General Use' ]]; then
${authchanger} -reset
${echo} "Command: Quit" >> ${depnotify_log}
${killall} loginwindow
${touch} ${munki_bootstrap}
fi

# Labs
if [[ ${computer_type} == 'Labs' ]]; then
${authchanger} -reset
${echo} "Command: Quit" >> ${depnotify_log}
${killall} loginwindow
${touch} ${munki_bootstrap}
fi

# Research Labs
if [[ ${computer_type} == 'Labs - Research' ]]; then
${authchanger} -reset
${echo} "Command: Quit" >> ${depnotify_log}
${killall} loginwindow
${touch} ${munki_bootstrap}
fi

# Podiums
if [[ ${computer_type} == 'Podiums' ]]; then
${authchanger} -reset
${echo} "Command: Quit" >> ${depnotify_log}
${killall} loginwindow
${touch} ${munki_bootstrap}
fi

# Servers
if [[ ${computer_type} == 'Servers' ]]; then
${authchanger} -reset
${echo} "Command: Quit" >> ${depnotify_log}
${killall} loginwindow
${touch} ${munki_bootstrap}
fi

exit
