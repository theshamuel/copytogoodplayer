#!/bin/sh
while getopts "s:f:" OPTION
do
    case $OPTION in
        s) SERVER="$OPTARG";;
        f) NAMES="$OPTARG";;
    esac
done

IFS=';' read -ra FILES <<< "$NAMES"

for i in "${FILES[@]}"; do
    mv -vf "$i" "$(dirname "$i")/$(basename "$i" | sed 's/[ ]/_/g')";
    echo Copying $i to $SERVER...
    response=$(curl --form upload=@./$i --form press=Submit http://$SERVER)
done
