#!/bin/bash
# enumerates the vhds in the path
storage="local-lvm"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

maxnum=0
list=$(find / -wholename "/dev/pve/vm-*")
for file in $list;
do
	filename=$(printf %q "$file")
	num=${filename:12:3}
	
	if [ $num -gt $maxnum ]
		then maxnum="$num"
	else maxnum="$maxnum"
	fi
done

if [ $maxnum -eq '0' ]
		then maxnum="100"
	else maxnum="$(($maxnum + 1))"
fi

find . -type f -name "*.vhd" -print0 | while IFS= read -r -d '' file; do
    filepath=$(printf %q "$file")
    echo $filepath
	#curr path
	path=${filepath%/*}
	# just the name
	name=${path##*/}
	
	# change the encoding
	cmd="sed -i -e 's/utf-16/utf-8/g' $path/$name.ovf"
	echo $cmd
	eval $cmd
	
	cmd="qm importovf $maxnum $path/$name.ovf $storage"
	echo $cmd
	eval $cmd
	
	cmd="qm importdisk $maxnum $filepath $storage"
	echo $cmd
	eval $cmd
	maxnum="$(($maxnum + 1))"
	
	echo " "
done
