#!/bin/bash
# Author: Tuncay ÇOLAK <tuncay.colak@tubitak.gov.tr>
#eklentilerin lider conf dosyalarındaki versiyonları değiştirilmelidir.
plugin_list="antivirus backup browser conky disk-quota firewall local-user login-manager network-manager package-manager password remote-access resource-usage restore rsyslog screensaver screenshot script service sudoers usb-ltsp usb user-privilege wol"


function change_conf {
	echo "değişecek dosya: "$file
	if [[ -f $file ]]; then
		sed -i -e 's/plugin.version = 1.0.0/plugin.version = 1.1/g' $file
		echo -e "lider konfigürasyon dosyasındaki versiyon değiştirildi"
	else
		echo "lider conf dosyası bulunamadı."
	fi
}
	
for pname in $plugin_list; do
	
	var1=$(echo $pname | cut -f1 -d-)
	echo $var1
	var2=$(echo $pname | cut -f2 -d-)
	echo $var2
	if [[ $var1 != $var2 ]]; then
		new=$var1$var2
		echo "----"$new
		file=plugins/lider-ahenk-$pname-plugin/lider-$pname/src/main/resources/tr.org.liderahenk.$new.cfg
		change_conf
	else
		echo "tek kelimeli eklenti..."
		file=plugins/lider-ahenk-$pname-plugin/lider-$pname/src/main/resources/tr.org.liderahenk.$var1.cfg
		change_conf
	fi
	
done
file_list="plugins/lider-ahenk-disk-quota-plugin/lider-disk-quota/src/main/resources/tr.org.liderahenk.disk.quota.cfg
plugins/lider-ahenk-disk-quota-plugin/lider-disk-quota/src/main/resources/tr.org.liderahenk.disk.quota.cfg
plugins/lider-ahenk-usb-ltsp-plugin/lider-usb-ltsp/src/main/resources/tr.org.liderahenk.usb.ltsp.cfg
plugins/lider-ahenk-remote-access-plugin/lider-remote-access/src/main/resources/tr.org.liderahenk.remote.access.cfg
"
for file in $file_list; do
	change_conf
done
