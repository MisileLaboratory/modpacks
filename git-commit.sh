#!/bin/bash
message=${0}
if [ -z "$1" ] || [ $# -eq 0 ]
	then
		echo "does not exist parameter"
		exit 1
fi
git add -A
git commit -am "$message"
