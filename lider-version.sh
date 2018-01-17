#!/bin/bash
# Author: Tuncay ÇOLAK <tuncay.colak@tubitak.gov.tr>
#lider ahenk 1.1 versiyonu  çıkarma

echo -e " ---->>> LİDER AHENK SÜRÜM YAYINLAMA <<<----\n"
plugin_list="conky backup"

function setup {
    echo -n "Bir işlem giriniz:[tag, commit, paket, exit] : "
    read job
    task $job
}

function task {
    for pname in $plugin_list; do
    	echo -e "["$pname"] eklentisi için girmiş olduğunuz işlemler gerçekleştirilecektir.. \n"

        if [[ $job == 'tag' ]]; then
            create_tag

        elif [[ $job == 'commit' ]]; then
            commit

        elif [[ $job == 'paket' ]]; then
            packeges

        elif [[ $job == 'exit' ]]; then
        	quit

        else
            echo -e "\n[UYARI] Tanımlanmamış bir işlem girdiniz. Lütfen [tag, commit, paket veya exit]\n işlemlerinden birini giriniz\n"
            setup
        fi
    done
}

function create_tag {

  cd lider-ahenk-$pname-plugin
  echo $pname " eklentisi"
  git tag -a v1.1 -m " plugin version 1.1"
  echo " tag oluşturuldu"
  git push origin v1.1
  echo "tag push edildi"
  git branch v1.1-branch v1.1
  echo "branch oluşturuldu"
  git checkout v1.1-branch
  echo "branch değiştirildi"
  cd ../
  /bin/bash sed.sh $pname
  echo $pname" eklentisinin lider projesi için versiyon güncellenmesi tamamlanmıştır."
  /bin/bash version_deb.sh $pname
  echo $pname" eklentisinin ahenk projesi için versiyon güncellenmesi tamamlanmıştır."
  echo -e "\n----------------------------------------------------------------------------\n"
}

function commit {

  echo -e "commit işlemi yapılacak\n"
  cd lider-ahenk-$pname-plugin
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
  /bin/bash scripts/build-plugin.sh
  echo "----->>> BUILD OK"
  echo -e "------------------------------------------------------------------------------------\n"
  cd ..
}

function packeges {

  echo -e "paket işlemi yapılacak\n"
  mkdir /home/tcolak/dev/lider-ahenk/v1.1/paketler/$pname

  cp /tmp/lider-ahenk-$pname-plugin/ahenk-${pname}_1.1_amd64.deb  /home/tcolak/dev/lider-ahenk/v1.1/paketler/$pname
  cp /tmp/lider-ahenk-$pname-plugin/lider-$pname-1.1.jar  /home/tcolak/dev/lider-ahenk/v1.1/paketler/$pname

  cd /home/tcolak/dev/lider-ahenk/v1.1/plugins/lider-ahenk-$pname-plugin/lider-console-$pname-feature/target/site

  zip -r lider-$pname-console_1.1.zip .
  cp lider-$pname-console_1.1.zip /home/tcolak/dev/lider-ahenk/v1.1/paketler/$pname

  echo "paketler kopyalandı"

  file=/home/tcolak/dev/lider-ahenk/v1.1/plugins/lider-ahenk-$pname-plugin/lider-$pname-db
  if [ -f $file ];then
      cd /home/tcolak/dev/lider-ahenk/v1.1/plugins/lider-ahenk-$pname-plugin/lider-$pname-db/target/lider-$pname-db-1.1.jar /home/tcolak/dev/lider-ahenk/v1.1/paketler/$pname
  else
      echo "db dosyası yok "
  fi
}

function quit {
	exit
}

#run setup function  
setup