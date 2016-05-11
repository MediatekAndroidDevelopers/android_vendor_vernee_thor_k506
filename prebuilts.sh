#!/bin/bash
while IFS= read -r FILE || [[ -n "$FILE" ]]; do
    if [ "$FILE" == "EOF" ] ; then
	exit 0
    fi
    PERM=999
    if [ -f ."$FILE" ] ; then
    	PERM=`stat -c "%a" ."$FILE"`
    fi
    adb pull /system/"$FILE" ."$FILE"
    if [ "$PERM" != "999" ] ; then
	chmod "$PERM" ."$FILE"
    fi
done < "prebuilts.txt"
