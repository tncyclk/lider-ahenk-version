#!/bin/bash

plugin_list="antivirus backup browser conky disk-quota firewall local-user login-manager network-manager package-manager password remote-access resource-usage restore rsyslog screensaver screenshot script service sudoers usb-ltsp usb user-privilege wol"

for pname in $plugin_list; do

  cd plugins/lider-ahenk-$pname-plugin
  git tag -d v1.1
  git push origin :v1.1
  git checkout master
  git branch -d v1.1-branch
  git branch
  echo "tag ve branch silindi "
  cd ../..
done
