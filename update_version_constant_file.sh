#!/bin/bash
# Author: Tuncay ÇOLAK <tuncay.colak@tubitak.gov.tr>

#lider-console-backup/src/tr/org/liderahenk/backup/constants/BackupConstants.java 
#dosyasında public static final String PLUGIN_VERSION = "1.0.0"; satırı public static final String PLUGIN_VERSION = "1.1"; olarak değiştirilir.

changeVersion(){
	sed -i -e 's/PLUGIN_VERSION = "1.0.0";/PLUGIN_VERSION = "1.1";/g' $file
	echo -e "Constants.java dosyasındaki version güncellendi."
}

if [[ $1 == 'backup' ]]; then
	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/backup/constants/BackupConstants.java
	changeVersion $file

elif [[ $1 == 'antivirus' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/antivirus/constants/AntivirusConstants.java
	changeVersion $file

elif [[ $1 == 'browser' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/browser/constants/BackupConstants.java
	changeVersion $file

elif [[ $1 == 'conky' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/conky/constants/ConkyConstants.java
	changeVersion $file

# elif [[ $1 == 'disk-limit' ]]; then

# 	file=lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/disklimit/constants/DiskLimitConstants.java
# 	changeVersion $file

elif [[ $1 == 'disk-quota' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/disk/quota/constants/DiskQuotaConstants.java
	changeVersion $file

elif [[ $1 == 'firewall' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/firewall/constants/FirewallConstants.java
	changeVersion $file

elif [[ $1 == 'local-user' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/localuser/constants/LocalUserConstants.java
	changeVersion $file

elif [[ $1 == 'login-manager' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/loginmanager/constants/LoginManagerConstants.java
	changeVersion $file

# elif [[ $1 == 'manage-root' ]]; then

# 	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/manageroot/constants/ManageRootConstants.java
# 	changeVersion $file

# elif [[ $1 == 'network-inventory' ]]; then

# 	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/network/inventory/constants/NetworkInventoryConstants.java
# 	changeVersion $file

elif [[ $1 == 'network-manager' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/networkmanager/constants/NetworkManagerConstants.java
	changeVersion $file

elif [[ $1 == 'package-manager' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/packagemanager/constants/PackageManagerConstants.java
	changeVersion $file

elif [[ $1 == 'password' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/password/constants/PasswordConstants.java
	changeVersion $file

elif [[ $1 == 'remote-access' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/remote/access/constants/RemoteAccessConstants.java
	changeVersion $file

elif [[ $1 == 'resource-usage' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/resourceusage/constants/ResourceUsageConstants.java
	changeVersion $file

elif [[ $1 == 'restore' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/restore/constants/RestoreConstants.java
	changeVersion $file

elif [[ $1 == 'rsyslog' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/rsyslog/constants/RsyslogConstants.java
	changeVersion $file

elif [[ $1 == 'screensaver' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/screensaver/constants/ScreensaverConstants.java
	changeVersion $file

elif [[ $1 == 'screenshot' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/screenshot/constants/ScreenshotConstants.java
	changeVersion $file

elif [[ $1 == 'script' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/script/constants/ScriptConstants.java
	changeVersion $file

elif [[ $1 == 'service' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/service/constants/ServiceConstants.java
	changeVersion $file

elif [[ $1 == 'sudoers' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/sudoers/constants/SudoersConstants.java
	changeVersion $file

elif [[ $1 == 'usb-ltsp' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/usb/ltsp/constants/UsbLtspConstants.java
	changeVersion $file

elif [[ $1 == 'usb' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/usb/constants/UsbConstants.java
	changeVersion $file

elif [[ $1 == 'user-privilege' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/user/privilege/constants/UserPrivilegeConstants.java
	changeVersion $file


elif [[ $1 == 'wol' ]]; then

	file=plugins/lider-ahenk-$1-plugin/lider-console-$1/src/tr/org/liderahenk/wol/constants/WolConstants.java
	changeVersion $file

else
	echo "eklenti bulunamadı."
fi
