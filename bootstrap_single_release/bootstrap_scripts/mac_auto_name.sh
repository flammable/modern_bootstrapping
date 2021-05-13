#!/bin/bash

awk="/usr/bin/awk"
curl="/usr/bin/curl"
defaults="/usr/bin/defaults"
find="/usr/bin/find"
grep="/usr/bin/grep"
scutil="/usr/sbin/scutil"
sed="/usr/bin/sed"
system_profiler="/usr/sbin/system_profiler"

mac_model=$(${system_profiler} SPHardwareDataType | ${awk} -F: '/Model Name/ {print $NF}' | ${sed} 's/^ *//')
serial_number=$(${system_profiler} SPHardwareDataType | ${awk} '/Serial/ {print $4}')

enrollment_info_plist="/Library/Managed Preferences/com.air-watch.Internal.UserDetails.plist"

if [[ -e "${enrollment_info_plist}" ]]; then
mac_user=$(${defaults} read "${enrollment_info_plist}" EnrollmentUser)
else
mac_user=$(${find} /Users -type d -maxdepth 1 -mindepth 1 | ${grep} -v "/Users/Shared" | ${grep} -v "/Users/mdmadmin" | ${sed} 's;\/Users\/;;g')
fi

# Apple hardware
if [[ ${mac_model} == 'MacBook Pro' ]]; then
mac_model="mbp"
fi

if [[ ${mac_model} == 'MacBook Air' ]]; then
mac_model="mbair"
fi

if [[ ${mac_model} == 'MacBook' ]]; then
mac_model="mb"
fi

if [[ ${mac_model} == 'iMac' ]]; then
mac_model="imac"
fi

if [[ ${mac_model} == 'iMac Pro' ]]; then
mac_model="imac"
fi

if [[ ${mac_model} == 'Mac mini' ]]; then
mac_model="mini"
fi

if [[ ${mac_model} == 'Mac Pro' ]]; then
mac_model="macpro"
fi

mac_name="${mac_user}"-"${mac_model}"

# Special cases
if [[ ${serial_number} == 'ABCDEFGHIJKLM' ]]; then
mac_name="custom-name"
fi

# Set the name of the computer
${scutil} --set ComputerName "${mac_name}"

# Set the Bonjour name
${scutil} --set LocalHostName "${mac_name}"

# Set the ClientIdentifier for Munki
${defaults} write /Library/Preferences/ManagedInstalls ClientIdentifier "${mac_name}"

# We have a service account specifically for Munki Enroll
munki_enroll_account="munki_enroll:password"

# Create a manifest for Faculty/Staff
munki_enroll_url="https://yourorg.tld/repo/munki-enroll/enroll_faculty_staff.php"
${curl} --max-time 5 --silent --get -d hostname="${mac_name}" --user "${munki_enroll_account}" "${munki_enroll_url}"

exit
