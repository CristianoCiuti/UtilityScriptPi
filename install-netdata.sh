#! /bin/bash
readlink=$( readlink -f -- "$0"; )
script_name=$( basename -- "$readlink"; )
base_dir=$( dirname -- "$readlink"; )
user=$1
if [ -z "$user" ]
then
    user=pi
fi

# installing Netdata
wget -O netdata-kickstart.sh https://my-netdata.io/kickstart.sh && sh netdata-kickstart.sh --non-interactive

# deleting script
rm netdata-kickstart.sh
rm $base_dir/$script_name