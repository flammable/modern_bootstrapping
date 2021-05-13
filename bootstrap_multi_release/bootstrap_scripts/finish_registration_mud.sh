#!/bin/bash

awk="/usr/bin/awk"
curl="/usr/bin/curl"
defaults="/usr/bin/defaults"
echo="/bin/echo"
scutil="/usr/sbin/scutil"
sleep="/bin/sleep"

# Wait for DEPNotify's registration to be completed
while [ ! -f /Users/Shared/UserInput.plist ]
do
  ${sleep} 1
done

# Location of DEPNotify's registration plist
registration_plist="/Users/Shared/UserInput.plist"

# Read computer name from DEPNotify.plist
computer_name=$(${defaults} read ${registration_plist} "Computer Name")

# Convert computer name to lowercase for cosmetic reasons
computer_name_lowercase=$(${echo} "${computer_name}" | ${awk} '{print tolower($0)}')

# Make sure the computer name isn't empty
if [[ "${computer_name_lowercase}" = "" ]]; then
 exit 1
fi

# Set the name of the computer
${scutil} --set ComputerName "${computer_name_lowercase}"

# Set the Bonjour name
${scutil} --set LocalHostName "${computer_name_lowercase}"

# Set the ClientIdentifier for Munki
${defaults} write /Library/Preferences/ManagedInstalls ClientIdentifier "${computer_name_lowercase}"

# Read the computer type from DEPNotify's registration plist
computer_type=$(${defaults} read ${registration_plist} "Computer Type")

# We have a service account specifically for Munki Enroll
munki_enroll_account="munki_enroll:password"

# Create a manifest for General Use
if [[ ${computer_type} == 'General Use' ]]; then
munki_enroll_url="https://yourorg.tld/repo/munki-enroll/enroll_genuse.php"
${curl} --max-time 5 --silent --get -d hostname="${computer_name_lowercase}" --user "${munki_enroll_account}" "${munki_enroll_url}"
fi

# Create a manifest for Labs
if [[ ${computer_type} == 'Labs' ]]; then
munki_enroll_url="https://yourorg.tld/repo/munki-enroll/enroll_labs.php"
${curl} --max-time 5 --silent --get -d hostname="${computer_name_lowercase}" --user "${munki_enroll_account}" "${munki_enroll_url}"
fi

# Create a manifest for Research Labs
if [[ ${computer_type} == 'Labs - Research' ]]; then
munki_enroll_url="https://yourorg.tld/repo/munki-enroll/enroll_labs_research.php"
${curl} --max-time 5 --silent --get -d hostname="${computer_name_lowercase}" --user "${munki_enroll_account}" "${munki_enroll_url}"
fi

# Create a manifest for Podiums
if [[ ${computer_type} == 'Podiums' ]]; then
munki_enroll_url="https://yourorg.tld/repo/munki-enroll/enroll_podiums.php"
${curl} --max-time 5 --silent --get -d hostname="${computer_name_lowercase}" --user "${munki_enroll_account}" "${munki_enroll_url}"
fi

# Create a manifest for Servers
if [[ ${computer_type} == 'Servers' ]]; then
munki_enroll_url="https://yourorg.tld/repo/munki-enroll/enroll_servers.php"
${curl} --max-time 5 --silent --get -d hostname="${computer_name_lowercase}" --user "${munki_enroll_account}" "${munki_enroll_url}"
fi

exit
