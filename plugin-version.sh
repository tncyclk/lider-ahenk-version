#!/bin/bash
# Author: Tuncay ÇOLAK <tuncay.colak@tubitak.gov.tr>
#lider ahenk 1.1 versiyonu  çıkarma

echo -e " ---->>> LİDER AHENK EKLENTİ SÜRÜMÜ YAYINLAMA <<<----\n"
plugin_list="antivirus backup browser conky disk-quota firewall local-user login-manager network-manager package-manager password remote-access resource-usage restore rsyslog screensaver screenshot script service sudoers usb-ltsp usb user-privilege wol"

#git clone plugin from repository
function setup {
  echo -n "Bir işlem giriniz:[tag, commit, copy, exit] : "
  read job
  task $job
}

function plugin_clone {
  git clone git@github.com:Pardus-LiderAhenk/lider-ahenk-$pname-plugin.git plugins/lider-ahenk-$pname-plugin
  echo $1" eklentisi kopyalandı."
  echo "--------------------------------------------------------------------------------"
}

function task {
  for pname in $plugin_list; do
    
    if [[ $job == 'tag' ]]; then
      echo -e "["$pname"] eklentisi için girmiş olduğunuz işlemler gerçekleştirilecektir.. \n" >> version.log
      plugin_clone
      create_tag

    elif [[ $job == 'commit' ]]; then
      echo -e "["$pname"] eklentisi için girmiş olduğunuz işlemler gerçekleştirilecektir.. \n" >> version.log
      commit

    elif [[ $job == 'copy' ]]; then
      echo -e "["$pname"] eklentisi için girmiş olduğunuz işlemler gerçekleştirilecektir.. \n" >> version.log
      packeges

    elif [[ $job == 'exit' ]]; then
      quit

    else
      echo -e "\n[UYARI] Tanımlanmamış bir işlem girdiniz. Lütfen [tag, commit, copy veya exit]\n işlemlerinden birini giriniz\n"
      setup
    fi
  done
}
 # yayınlanacak versiyon bilgisine ait tag oluşturuluyor.
function create_tag {

  cd plugins/lider-ahenk-$pname-plugin
  echo $pname " eklentisi"
  git tag -a v1.1 -m " plugin version 1.1"
  echo " tag oluşturuldu"
  git push origin v1.1
  echo "tag push edildi"
  git branch v1.1-branch v1.1
  echo "branch oluşturuldu"
  git checkout v1.1-branch
  echo "branch değiştirildi"
  cd ../..
  /bin/bash update_version.sh $pname
  echo $pname" eklentisinin lider projesi için versiyon güncellenmesi tamamlanmıştır." >> version.log
  /bin/bash update_version_deb.sh $pname
  echo $pname" eklentisinin ahenk projesi için versiyon güncellenmesi tamamlanmıştır."
  echo -e "\n----------------------------------------------------------------------------\n" >> version.log
}

#Versiyon değişiklikleri github a commit ediliyor.
function commit {

  echo -e "commit işlemi yapılacak\n"
  cd plugins/lider-ahenk-$pname-plugin
  echo "----->>> "$pname " eklentisi commit ediliyor.."
  git add .
  echo "------>>> değişiklikler locale eklendi"
  git commit -m "version name fix: 1.1"
  echo "----->>> version commitlendi"
  git tag -d v1.1
  echo "------>>> yerelden tag silindi"
  git tag v1.1
  echo "------>>> tag oluşturuldu"
  git push origin :v1.1
  echo "------->>> uzaktan tag silindi"
  git push origin v1.1
  echo "------>>> tag push edildi"
  echo -e "------------------------------------------------------------------------------------\n"
  cd ../..
}

function packeges {
  /bin/bash plugins/lider-ahenk-$pname-plugin/scripts/build-plugin.sh
  echo "["$pname"] ----------------->>> BUILD OK <<<--------------------" >> build.log

  echo -e "["$pname"] --->> paket kopyalama işlemi yapılacak\n" >> build.log
  #mkdir paketler/$pname

  cp /tmp/lider-ahenk-$pname-plugin/ahenk-${pname}_1.1_amd64.deb  paketler/$pname
  cp /tmp/lider-ahenk-$pname-plugin/lider-$pname-1.1.jar  paketler/$pname

  zip -r paketler/$pname/lider-$pname-console_1.1.zip plugins/lider-ahenk-$pname-plugin/lider-console-$pname-feature/target/site
  
  echo "["$pname"] --->> paketler kopyalandı" >> build.log

  file=plugins/lider-ahenk-$pname-plugin/lider-$pname-db
  if [[ -d $file ]];then
    cp plugins/lider-ahenk-$pname-plugin/lider-$pname-db/target/lider-$pname-db-1.1.jar paketler/$pname
  else
    echo "["$pname"] --->> db dosyası yok " >> build.log
  fi
}

function quit {
	echo "çıkış yapılıyor..."
	exit
}
if [[ -d "plugins" ]]; then
  echo "plugins dizini zaten var"
else
  mkdir plugins
fi

if [[ -d "paketler" ]]; then
  echo "paketler dizini zaten var"
else
  mkdir paketler
fi
#run setup function  
setup