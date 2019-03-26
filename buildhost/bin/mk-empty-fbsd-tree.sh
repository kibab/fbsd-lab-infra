#!/bin/sh

if [ $# -ne 2 ]; then
    echo "Usage: $0 source_dir destination_dir"
    echo "	source_dir is the FreeBSD root directory"
    echo "	destination_dir is where to create an empty FreeBSD hierarchy"
    exit 127
fi
mtrees="root usr var"
dist_dir=$1
dest_dir=$2

[ -d $dest_dir ] || mkdir $dest_dir
for m in $mtrees; do
    if [ $m = 'root' ]; then
        d=/
    else
        d=$m
    fi
    mtree -deU -N $dist_dir/etc -f $dist_dir/etc/mtree/BSD.${m}.dist -p $dest_dir/$d
done
