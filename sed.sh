#!/bin/bash
# Author: Tuncay ÇOLAK <tuncay.colak@tubitak.gov.tr>
#lider ahenk version çıkartma


#lider eklentisi için;
file=lider-ahenk-$1-plugin/pom.xml
if [[ -f $file ]];then

	sed -i -e 's/<version>1.0.0<\/version>/<version>1.1<\/version>/g' $file
	echo "--->> pom.xml version 1.1 yapıldı"
else

	echo "dosya bulunamadı..!"
fi

cd lider-ahenk-$1-plugin
mvn -N versions:update-child-modules
echo "[BUILD SUCCESS] alt module versiyonları değiştirildi"

file=lider-ahenk-$1-plugin/lider-$1/pom.xml

if [[  -f $file ]]; then
	sed -i -e 's/<Bundle-Version>1.0.0<\/Bundle-Version>/<Bundle-Version>1.1<\/Bundle-Version>/g' $file
	echo "--->> lider-"$1"/pom.xml dosyasındaki Bundle-Version 1.1 yapıldı"
	content=lider-$1-db
	echo "dosya içeriği: "$content

	if grep -Fxq '$content' $file; then
		echo "eklentinin db projesi tanımlanmıştır"
		sed -i -e 's/<version>1.0.0<\/version>/<version>1.1<\/version>/g' $file
		echo "db versiyonu 1.1 yapıldı"
	else
		echo "db projesi tanımlanmamıştır."
	fi
else
  echo "dosya bulunamadı...!!"
fi
