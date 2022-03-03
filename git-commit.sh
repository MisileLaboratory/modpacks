#!/bin/bash
message=""
for i in $(seq 1 $#)
do
	echo "$message$i"
	message="$message$i"
done
if ["$message" == ""]
	then
		echo "no parameter"
		exit 1
fi
git add -A
git commit -am "$message"
