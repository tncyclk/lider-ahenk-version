#!/bin/bash
# Author: Tuncay ÇOLAK <tuncay.colak@tubitak.gov.tr>

#eklentilerin ahenk versyonlarını güncellemek için debian dizini altında yer alan changelog ve control dosyalarındaki ve eklenti 
# dizini altında yer alan main.py dosyasındaki versiyon bilgisi güncellenir.

file=lider-ahenk-$1-plugin/ahenk-$1/debian/changelog
if [[ -f $file ]]; then
	sed -i -e 's/(1.0.0)/(1.1)/g' $file
	echo "changelog dosyası güncellendi"
else
	echo "changelog dosyası bulunamadı"
fi

file=lider-ahenk-$1-plugin/ahenk-$1/debian/control
if [[ -f $file ]]; then
	sed -i -e 's/Version: 1.0.0/Version: 1.1/g' $file
	echo "control dosyası güncellendi"
else
	echo "control dosyası bulunamadı"
fi

file=lider-ahenk-$1-plugin/ahenk-$1/$1/main.py
if [[ -f $file ]]; then
	sed -i -e 's/'1.0.0'/'1.1'/g' $file
	echo "main.py dosyası güncellendi"
else
	echo "main.py dosyası bulunamadı"
fi



