#! /bin/bash
readlink=$( readlink -f -- "$0"; )
script_name=$( basename -- "$readlink"; )
base_dir=$( dirname -- "$readlink"; )
user=$1
if [ -z "$user" ]
then
    user=pi
fi

# installing required package
sudo apt update && sudo apt install nodejs npm git -y
sudo npm install -g pm2
sudo pm2 startup

# installing Linux Dash
git clone --depth 1 https://github.com/afaqurk/linux-dash.git /home/$user/git/linux-dash || true
cd /home/$user/git/linux-dash && git reset --hard && git pull
cd app/server
npm install --production
pm2 start index.js --port 7575
pm2 save

# deleting script
rm $base_dir/$script_name