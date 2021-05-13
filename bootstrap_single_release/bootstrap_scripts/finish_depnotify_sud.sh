#!/bin/bash

authchanger="/usr/local/bin/authchanger"
defaults="/usr/bin/defaults"
echo="/bin/echo"
killall="/usr/bin/killall"

# Location of DEPNotify's registration plist
registration_plist="/Users/Shared/UserInput.plist"

# Read the computer type from DEPNotify's registration plist
computer_type=$(${defaults} read ${registration_plist} "Computer Type")

# Set DEPNotify log location
depnotify_log="/var/tmp/depnotify.log"

# Prepare to allow the user to login
${authchanger} -reset -AD

# Exit NoLoNotify
${echo} "Command: Quit" >> ${depnotify_log}

# Relaunch the login window
${killall} loginwindow

exit
