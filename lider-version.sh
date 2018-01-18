#!/bin/bash
# Author: Tuncay ÇOLAK <tuncay.colak@tubitak.gov.tr>

echo -e " ---->>> LİDER SÜRÜM YAYINLAMA <<<----\n"
#git clone ve 1.1 tagı oluşturma
git clone git@github.com:Pardus-LiderAhenk/lider.git

cd lider
git tag -a v1.1 -m " lider version 1.1"
echo " tag oluşturuldu" >> ../lider.log
git push origin v1.1
echo "tag push edildi" >> ../lider.log
git branch v1.1-branch v1.1
echo "branch oluşturuldu" >> ../lider.log
git checkout v1.1-branch
echo "branch değiştirildi" >> ../lider.log
cd ..
#---------------------------------------------------------------------------


function changeVersion {
	sed -i -e 's/<version>1.0.0-SNAPSHOT<\/version>/<version>1.1<\/version>/g' $file
	echo -e "["$file"] dosyasında versiyon bilgisi değiştirildi \n"
}

while read file
do
	echo "----->>> "$file
	if [[ -f $file ]]; then
		changeVersion $file 
	else
		echo "["$file"] dosya bulunamadı"
	fi
done < lider_file

#file=lider/lider-karaf/src/main/feature/feature.xml
#if [[ -f $file ]]; then
#	sed -i -e 's/1.0.0/1.1/g' $file
#	echo -e "["$file"] dosyasında versiyon bilgisi değiştirildi \n"
#else
#	echo "["$file"] dosya bulunamadı"
#fi
