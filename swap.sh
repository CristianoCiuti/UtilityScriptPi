#! /bin/bash
readlink=$( readlink -f -- "$0"; )
script_name=$( basename -- "$readlink"; )
base_dir=$( dirname -- "$readlink"; )
size=$1
if [ -z "$size" ]
then
    size=1024
fi

# update swap size
sudo dphys-swapfile swapoff
sudo sed -i '/CONF_SWAPSIZE/d' /etc/dphys-swapfile
echo "CONF_SWAPSIZE=$size" | sudo tee --append /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon

# deleting script
rm $base_dir/$script_name

# rebooting
sudo reboot