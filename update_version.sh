#!/bin/bash
# Author: Tuncay ÇOLAK <tuncay.colak@tubitak.gov.tr>
#lider ahenk 1.1 versiyonu  çıkarma

#lider eklentisi için;
file=plugins/lider-ahenk-$1-plugin/pom.xml
echo $file
if [[ -f $file ]];then

	sed -i -e 's/<version>1.0.0<\/version>/<version>1.1<\/version>/g' $file
	echo "--->> pom.xml version 1.1 yapıldı"
else
	echo "dosya bulunamadı..!"
fi

cd plugins/lider-ahenk-$1-plugin
mvn -N versions:update-child-modules
echo "[BUILD SUCCESS] alt module versiyonları değiştirildi"
file=lider-$1/pom.xml
if [[ -f $file ]];then
	echo "------>>> if e girdim"
	sed -i -e 's/<Bundle-Version>1.0.0<\/Bundle-Version>/<Bundle-Version>1.1<\/Bundle-Version>/g' $file
	echo -e "--->> lider-"$1"/pom.xml dosyasındaki Bundle-Version 1.1 yapıldı"

	sonuc=$(grep lider-$1-db $file)
	echo -e "sonuc: "$sonuc

	if [[ ! -z $sonuc ]]; then

		echo "eklentinin db projesi tanımlanmıştır"
		sed -i -e 's/<version>1.0.0<\/version>/<version>1.1<\/version>/g' $file
		echo "db versiyonu 1.1 yapıldı"
	else
		echo "db projesi tanımlanmamıştır."
	fi
else
	echo "dosya bulunamadı...!!"
fi
#---------------------------------------------------------------------------
file=lider-$1/src/main/resources/tr.org.liderahenk.$1.cfg
if [[ -f $file ]]; then
	sed -i -e 's/plugin.version = 1.0.0/plugin.version = 1.1/g' $file
	echo -e "lider konfigürasyon dosyasındaki versiyon değiştirildi"
else
	echo "lider conf dosyası bulunamadı."
fi 
#---------------------------------------------------------------------------
#lider-console projesi için version güncelleme
file=lider-console-$1/META-INF/MANIFEST.MF
if [[ -f $file ]]; then
	sed -i -e 's/Bundle-Version: 1.0.0/Bundle-Version: 1.0.0.qualifier/g' $file
	echo -e "MANIFEST.MF dosyasındaki version güncellendi."
else
	echo "MANIFEST.MF dosyası bulunamadı.."
fi
#---------------------------------------------------------------------------
file=lider-console-$1/plugin.xml
if [[ -f $file ]]; then
	sed -i -e 's/pluginVersion="1.0.0"/pluginVersion="1.1"/g' $file
	echo -e "lider-console plugin.xml dosyasındaki version güncellendi."
else
	echo "lider-console plugin.xml dosyası bulunamadı."
fi
#---------------------------------------------------------------------------
#lider-console-backup/pom.xml dosyasında parent tagının kapandığı yerin altında <version>1.0.0-SNAPSHOT</version> eklenir.
file=lider-console-$1/pom.xml
if [[ -f $file ]]; then
	sed -i -e 's/<\/parent>/<\/parent>\n <version>1.0.0-SNAPSHOT<\/version>/g' $file
	echo -e "lider-console pom.xml dosyasındaki version güncellendi."
else
	echo "lider console pom.xml dosyası bulunamadı.."
fi
#---------------------------------------------------------------------------
#lider-console-backup-feature/pom.xml dosyasında parent tagının kapandığı yerin altında <version>1.0.0-SNAPSHOT</version> eklenir.
file=lider-console-$1-feature/pom.xml
if [[ -f $file ]]; then
	sed -i -e 's/<\/parent>/<\/parent>\n <version>1.0.0-SNAPSHOT<\/version>/g' $file
	echo -e "lider-console-feature pom.xml dosyasındaki version güncellendi."
else
	echo "lider-console-feature pom.xml dosyası bulunamadı.."
fi
#---------------------------------------------------------------------------
# lider-console-backup plugini versiyonu 1.0.0 dan 1.0.0.qualifier olarak değiştirilir. 
# yine lider-console-backup-feature projesinin versiyonu 1.0.0 değeri 1.0.0.qualifier olarak değiştirilir.
file=lider-console-$1-feature/feature.xml
if [[ -f $file ]]; then
	sed -i -e 's/version="1.0.0"/version="1.0.0.qualifier"/g' $file
	echo -e "lider-console-feature feature.xml dosyasındaki version güncellendi."
else
	echo "lider-console-feature feature.xml dosyası bulunamadı.."
fi

#---------------------------------------------------------------------------
#lider-console-backup/src/tr/org/liderahenk/backup/constants/BackupConstants.java 
#dosyasında public static final String PLUGIN_VERSION = "1.0.0"; satırı public static final String PLUGIN_VERSION = "1.1"; olarak değiştirilir.
plName=$1
cd ../..
echo "plugin name: "$plName
/bin/bash update_version_constant_file.sh $plName
#---------------------------------------------------------------------------
# file=lider-ahenk-$1-plugin/scripts/build-plugin.sh
# if [[ -f $file ]]; then
# 	sed -i -e 's/mvn clean install -DskipTests/mvn clean install -DskipTests -DforceContextQualifier=1.1/g' $file
# 	echo "buiid dosyasındaki versiyon bilgisi güncellendi"
# else
# 	echo "dosya bulunamadı"
# fi