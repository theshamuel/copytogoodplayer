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
    i=$(echo $i | sed 's/[\]//g')
    i_new=$(echo $i | sed 's/[ ]/_/g')
    mv -vf "$i" "$(dirname "$i")/$(basename "$i_new" | sed 's/[ ]/_/g')";
    echo Copying $i to $SERVER...
    response=$(curl --form upload=@./$i_new --form press=Submit http://$SERVER)
done
