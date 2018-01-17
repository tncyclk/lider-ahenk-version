#!/bin/bash
cd plugins/lider-ahenk-$1-plugin
git tag -d v1.1
git push origin :v1.1
git checkout master
git branch -d v1.1-branch
git branch
echo "tag ve branch silindi "
