#!/bin/bash
# Author: Tuncay ÇOLAK <tuncay.colak@tubitak.gov.tr>
#lider ahenk 1.1 versiyonu  çıkarma

echo -e " ---->>> LİDER AHENK SÜRÜM YAYINLAMA <<<----\n"
plugin_list="conky backup"

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

    echo -e "["$pname"] eklentisi için girmiş olduğunuz işlemler gerçekleştirilecektir.. \n"
    plugin_clone

    if [[ $job == 'tag' ]]; then
      create_tag

    elif [[ $job == 'commit' ]]; then
      commit

    elif [[ $job == 'copy' ]]; then
      packeges

    elif [[ $job == 'exit' ]]; then
      quit

    else
      echo -e "\n[UYARI] Tanımlanmamış bir işlem girdiniz. Lütfen [tag, commit, copy veya exit]\n işlemlerinden birini giriniz\n"
      setup
    fi
  done
}

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
  /bin/bash sed.sh $pname
  echo $pname" eklentisinin lider projesi için versiyon güncellenmesi tamamlanmıştır."
  /bin/bash version_deb.sh $pname
  echo $pname" eklentisinin ahenk projesi için versiyon güncellenmesi tamamlanmıştır."
  echo -e "\n----------------------------------------------------------------------------\n"
  commit
}

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
  echo "----------------->>> BUILD OK <<<--------------------"

  echo -e "paket işlemi yapılacak\n"
  mkdir paketler/$pname

  cp /tmp/lider-ahenk-$pname-plugin/ahenk-${pname}_1.1_amd64.deb  paketler/$pname
  cp /tmp/lider-ahenk-$pname-plugin/lider-$pname-1.1.jar  paketler/$pname

  zip -r plugins/lider-ahenk-$pname-plugin/lider-console-$pname-feature/target/site/lider-$pname-console_1.1.zip .
  cp plugins/lider-ahenk-$pname-plugin/lider-console-$pname-feature/target/site/lider-$pname-console_1.1.zip paketler/$pname

  echo "paketler kopyalandı"

  file=/home/tcolak/dev/lider-ahenk/v1.1/plugins/lider-ahenk-$pname-plugin/lider-$pname-db
  if [ -f $file ];then
    cd /home/tcolak/dev/lider-ahenk/v1.1/plugins/lider-ahenk-$pname-plugin/lider-$pname-db/target/lider-$pname-db-1.1.jar /home/tcolak/dev/lider-ahenk/v1.1/paketler/$pname
  else
    echo "db dosyası yok "
  fi
}

function quit {
	echo "çıkış yapılıyor..."
	exit
}
mkdir plugins
mkdir paketler
#run setup function  
setup