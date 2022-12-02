#! /bin/bash

echo 'deb http://archive.raspbian.org/raspbian stretch main contrib non-free rpi' | sudo tee /etc/apt/sources.list.d/raspbian_stretch_for_mongodb.list
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt-get autoclean -y
sudo apt install openjdk-8-jre-headless jsvc libcommons-daemon-java -y
sudo apt install mongodb-server mongodb-clients -y
sudo apt install apt-transport-https -y
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
sudo apt update && sudo apt install unifi -y