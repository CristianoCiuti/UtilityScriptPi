#! /bin/bash
readlink=$( readlink -f -- "$0"; )
script_name=$( basename -- "$readlink"; )
base_dir=$( dirname -- "$readlink"; )
user=$1
if [ -z "$user" ]
then
    user=pi
fi

# creating smb folder
mkdir -p /home/$user/smb/conf
mv $base_dir/$script_name /home/$user/smb/$script_name

# installing required package
sudo apt update && sudo apt install ntfs-3g samba samba-common-bin -y

# configuring public folder
mkdir -p /home/$user/public
wget "https://github.com/CristianoCiuti/UtilityScriptPi/raw/master/conf/smb.conf" -O /home/$user/smb/conf/smb.conf
cat /home/$user/smb/conf/smb.conf | sudo tee --append /etc/samba/smb.conf
echo "path = /home/$user/public" | sudo tee --append /etc/samba/smb.conf
sudo systemctl restart smbd.service