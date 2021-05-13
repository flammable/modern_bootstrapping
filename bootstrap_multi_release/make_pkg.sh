#!/bin/bash

# Binaries
basename="/usr/bin/basename"
codesign="/usr/bin/codesign"
echo="/bin/echo"
munkiimport="/usr/local/munki/munkiimport"
munkipkg="/usr/local/munki-pkg/munkipkg"
open="/usr/bin/open"
PlistBuddy="/usr/libexec/PlistBuddy"
rm="/bin/rm"
xattr="/usr/bin/xattr"

# Determine variables to make this script more generic
pkg_name="$(${basename} ${PWD})"
pkg_version="$(${PlistBuddy} -c 'print version' ./build-info.plist)"

# This is the cert we're using to sign files for TCC
signing_cert="Developer ID Application: Your Organization (ABCDE12345)"

# Array of files we're signing
files_to_sign=('./payload/Library/installapplications/installapplications.py')

# Remove extended attributes, then sign files for TCC
for i in "${files_to_sign[@]}"
do
   ${xattr} -cr "$i"
   ${codesign} -s "${signing_cert}" -i tld.yourorg.${pkg_name} "$i"
done

# Delete stray .DS_Store file in /payload
# This fixes the error: The operation couldn’t be completed. Can't find "." in bom file
if [[ -e ./payload/.DS_Store ]]; then
 ${rm} ./payload/.DS_Store
fi

# Build the pkg
# Normally, we'd run `${munkipkg} .` but instead we're exporting Bom info to Bom.txt for Git tracking of permissions
# If building this package after running `git clone`, be sure to run `${munkipkg} --sync .` first
${munkipkg} --export-bom-info .

# Show the newly built pkg for uploading into the MDM console.
${open} ./build/

${echo}
${echo} "Usage:"
${echo} "Assignment Name: bootstrap_multi_release"
${echo} "Assignments: bootstrap_multi_release"
${echo} "Exclusions: bootstrap_multi_testing"
${echo}

exit
