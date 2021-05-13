#!/bin/bash

basename="/usr/bin/basename"
dirname="/usr/bin/dirname"
echo="/bin/echo"
mv="/bin/mv"
python="/usr/local/bin/python3"
rsync="/usr/bin/rsync"

generatejson="./generatejson.py"

baseurl="https://yourorg.tld/bootstrap"
ia_share="/Volumes/bootstrap"
bootstrap_name="$(${basename} ${PWD})"
bootstrap_path="$(${dirname} ${PWD})"

if [ ! -d ${ia_share} ]; then
 ${echo} "Bootstrap file share not found, please mount and retry."
 exit 1
fi

${rsync} -avz --delete "${bootstrap_path}"/"${bootstrap_name}"/bootstrap_scripts/ "${ia_share}"/scripts/"${bootstrap_name}"

# preflight
# setupassistant
# userland

# --item \
# item-name='A name' \
# item-path='A path' \
# item-stage='preflight' \
# item-type='A type' \
# item-url='A url' \
# script-do-not-wait='A boolean' \

${python} ${generatejson} \
--item \
item-name='IA Preflight' \
item-path="${ia_share}"/scripts/"${bootstrap_name}"/'preflight.py' \
item-stage='preflight' \
item-type='rootscript' \
item-url="${baseurl}"/scripts/"${bootstrap_name}"/'preflight.py' \
script-do-not-wait=false \
\
\
\
--item \
item-name='Login Window Background' \
item-path="${ia_share}"/pkgs/'background_grey.pkg' \
item-stage='setupassistant' \
item-type='package' \
item-url="${baseurl}"/pkgs/'background_grey.pkg' \
script-do-not-wait=false \
\
--item \
item-name='Logo' \
item-path="${ia_share}"/pkgs/'logo.pkg' \
item-stage='setupassistant' \
item-type='package' \
item-url="${baseurl}"/pkgs/'logo.pkg' \
script-do-not-wait=false \
\
--item \
item-name='NoMAD Login AD' \
item-path="${ia_share}"/pkgs/'NoMADLogin-1.4.0-multiplatform.pkg' \
item-stage='setupassistant' \
item-type='package' \
item-url="${baseurl}"/pkgs/'NoMADLogin-1.4.0-multiplatform.pkg' \
script-do-not-wait=false \
\
--item \
item-name='bootstrap_sud' \
item-path="${ia_share}"/pkgs/'bootstrap_sud.pkg' \
item-stage='setupassistant' \
item-type='package' \
item-url="${baseurl}"/pkgs/'bootstrap_sud.pkg' \
script-do-not-wait=false \
\
--item \
item-name='Install Rosetta on Apple Silicon' \
item-path="${ia_share}"/scripts/"${bootstrap_name}"/'install_rosetta_on_apple_silicon.sh' \
item-stage='setupassistant' \
item-type='rootscript' \
item-url="${baseurl}"/scripts/"${bootstrap_name}"/'install_rosetta_on_apple_silicon.sh' \
script-do-not-wait=false \
\
--item \
item-name='MSC Background Process' \
item-path="${ia_share}"/pkgs/'munkitools_launchd-3.0.3265.pkg' \
item-stage='setupassistant' \
item-type='package' \
item-url="${baseurl}"/pkgs/'munkitools_launchd-3.0.3265.pkg' \
script-do-not-wait=false \
\
--item \
item-name='MSC Embedded Python' \
item-path="${ia_share}"/pkgs/'munkitools_python-3.9.4.4346.pkg' \
item-stage='setupassistant' \
item-type='package' \
item-url="${baseurl}"/pkgs/'munkitools_python-3.9.4.4346.pkg' \
script-do-not-wait=false \
\
--item \
item-name='MSC Core' \
item-path="${ia_share}"/pkgs/'munkitools_core-5.4.0.4348.pkg' \
item-stage='setupassistant' \
item-type='package' \
item-url="${baseurl}"/pkgs/'munkitools_core-5.4.0.4348.pkg' \
script-do-not-wait=false \
\
--item \
item-name='Set Time Zone - Eastern' \
item-path="${ia_share}"/scripts/"${bootstrap_name}"/'set_time_zone_eastern.sh' \
item-stage='setupassistant' \
item-type='rootscript' \
item-url="${baseurl}"/scripts/"${bootstrap_name}"/'set_time_zone_eastern.sh' \
script-do-not-wait=false \
\
--item \
item-name='Bless VM' \
item-path="${ia_share}"/scripts/"${bootstrap_name}"/'bless_vm.py' \
item-stage='setupassistant' \
item-type='rootscript' \
item-url="${baseurl}"/scripts/"${bootstrap_name}"/'bless_vm.py' \
script-do-not-wait=false \
\
--item \
item-name='MSC Bootstrap' \
item-path="${ia_share}"/scripts/"${bootstrap_name}"/'munki_bootstrap_sud.py' \
item-stage='setupassistant' \
item-type='rootscript' \
item-url="${baseurl}"/scripts/"${bootstrap_name}"/'munki_bootstrap_sud.py' \
script-do-not-wait=false \
\
--item \
item-name='Delete iLife and iWork' \
item-path="${ia_share}"/scripts/"${bootstrap_name}"/'delete_ilife_iwork.sh' \
item-stage='setupassistant' \
item-type='rootscript' \
item-url="${baseurl}"/scripts/"${bootstrap_name}"/'delete_ilife_iwork.sh' \
script-do-not-wait=false \
\
--item \
item-name='Load MSC Background Process' \
item-path="${ia_share}"/scripts/"${bootstrap_name}"/'munki_launchd_loader.py' \
item-stage='setupassistant' \
item-type='rootscript' \
item-url="${baseurl}"/scripts/"${bootstrap_name}"/'munki_launchd_loader.py' \
script-do-not-wait=false \
\
--item \
item-name='Name this Mac' \
item-path="${ia_share}"/scripts/"${bootstrap_name}"/'mac_auto_name.sh' \
item-stage='setupassistant' \
item-type='rootscript' \
item-url="${baseurl}"/scripts/"${bootstrap_name}"/'mac_auto_name.sh' \
script-do-not-wait=false \
\
--item \
item-name='Run MSC' \
item-path="${ia_share}"/scripts/"${bootstrap_name}"/'munki_auto_trigger.py' \
item-stage='setupassistant' \
item-type='rootscript' \
item-url="${baseurl}"/scripts/"${bootstrap_name}"/'munki_auto_trigger.py' \
script-do-not-wait=true \
\
--item \
item-name='Finish DEPNotify' \
item-path="${ia_share}"/scripts/"${bootstrap_name}"/'finish_depnotify_sud.sh' \
item-stage='setupassistant' \
item-type='rootscript' \
item-url="${baseurl}"/scripts/"${bootstrap_name}"/'finish_depnotify_sud.sh' \
script-do-not-wait=false \
\
\
\
--base-url "${baseurl}" \
--output "${ia_share}"

${mv} -v "${ia_share}"/bootstrap.json "${ia_share}"/"${bootstrap_name}".json

exit
