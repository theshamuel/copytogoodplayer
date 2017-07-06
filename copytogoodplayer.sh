#!/bin/sh

while getopts "s:f:" OPTION
do
    case $OPTION in
        s) SERVER="$OPTARG";;
        f) NAMES="$OPTARG";;
    esac
done

IFS=' ' read -ra FILES <<< "$NAMES"

for i in "${FILES[@]}"; do
    echo Copying $i...
    response=$(curl --form upload=@$i --form press=Submit http://$SERVER)
done
