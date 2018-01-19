#!/bin/bash

plugin_list="antivirus backup browser conky disk-quota firewall local-user login-manager network-manager package-manager password remote-access resource-usage restore rsyslog screensaver screenshot script service sudoers usb-ltsp usb user-privilege wol"

function delete_tag {

  git tag -d v1.1
  git push origin :v1.1
  git checkout master
  git branch -d v1.1-branch
  git branch
  echo "tag ve branch silindi "
}

function lider_tag {
  cd lider
  delete_tag
}

function plugins_tag {
  for pname in $plugin_list; do
    cd plugins/lider-ahenk-$pname-plugin
    delete_tag
    cd ../..
  done
}

function quit {
  exit  
}

echo "hangi tagı silmek isyitosunuz[lider, plugins, exit]: "
read deg

if [[ $deg == 'lider' ]]; then
  echo "lider tagı silinecek"
  lider_tag

elif [[ $deg == 'plugins' ]]; then
  echo "eklentilerin tagı silinecek"
  plugins_tag

elif [[ $deg == 'exit' ]]; then
	echo "cıkış yapılıyor..."
  quit

else
  echo "Tanımlanmamış bir işlem girdiniz... "

fi
