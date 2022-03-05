#!/bin/bash
message=""
for i in "$@"
do
	message="$message $i"
done
message="${message:1}"
if [$message == ""]
	then
		echo "no parameter"
		exit 1
fi
git add -A
git commit -am "$message"
