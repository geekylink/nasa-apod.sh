#!/bin/bash
bgDir="/mnt/d/Pictures/backgrounds/"
dateStr=$(date "+%Y%m%d")

download_pic () {

    wget -O astropix.html https://apod.nasa.gov/apod/astropix.html
    fileName=$(cat astropix.html | grep -i img | sed "s/^.*=\"//" | sed "s/\".*$//")
    fileExt=$(cat astropix.html | grep -i img | sed "s/^.*\.//" | sed "s/\".*$//")
    fullURL="https://apod.nasa.gov/apod/$fileName"
    saveFile="nasa-$dateStr.$fileExt"
    fullFile="$bgDir$saveFile"
    echo "Saving to $fullFile"
    wget -O $fullFile $fullURL 
    rm astropix.html

}

is_file_exist () {

    saveFile="nasa-$dateStr.*"
    fullFile="$bgDir$saveFile"

    fileExt=$(echo $fullFile | sed "s/^.*\.//")

    saveFile="nasa-$dateStr.$fileExt"
    fullFile="$bgDir$saveFile"


    if [[ ! -f $fullFile ]] ; then
        return 1
    fi

    return 0

}

is_file_exist

if [[ $? == 1 ]] ; then
    echo "Downloading"
    download_pic
else
    echo "Nothing to do"
fi
