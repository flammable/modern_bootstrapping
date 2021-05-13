#!/bin/bash

echo="/bin/echo"
pkgutil="/usr/sbin/pkgutil"
rm="/bin/rm"

# Delete iLife and iWork apps, if present - these can be obtained through Munki instead

${rm} -rf "/Applications/iMovie.app"
${rm} -rf "/Applications/iPhoto.app"
${rm} -rf "/Applications/GarageBand.app"

${rm} -rf "/Applications/Pages.app"
${rm} -rf "/Applications/Keynote.app"
${rm} -rf "/Applications/Numbers.app"

# Delete GarageBand loops, too

${rm} -rf "/Library/Audio/Apple Loops"
${rm} -rf "/Library/Audio/Impulse Responses"
${rm} -rf "/Library/Application Support/Logic"
${rm} -rf "/Library/Application Support/GarageBand"

# Delete pkg receipts for GarageBand loops

${pkgutil} --forget com.apple.pkg.MAContent10_GarageBandCoreContent
${pkgutil} --forget com.apple.pkg.MAContent10_GarageBandCoreContent2
${pkgutil} --forget com.apple.pkg.MAContent10_GarageBandPremiumContent
${pkgutil} --forget com.apple.pkg.MAContent10_GB_StereoDrumKitsAlternative
${pkgutil} --forget com.apple.pkg.MAContent10_GB_StereoDrumKitsRnB
${pkgutil} --forget com.apple.pkg.MAContent10_GB_StereoDrumKitsRock
${pkgutil} --forget com.apple.pkg.MAContent10_GB_StereoDrumKitsSongWriter
${pkgutil} --forget com.apple.pkg.MGBContentCompatibility

exit 0
