#!/bin/bash
# please change your home directory here
file1=/home/user/1
file2=/home/user/2

sudo bash -c "touch "$file1""
sudo bash -c "touch "$file2""

sudo bash -c "grep -L "psk=" /etc/NetworkManager/system-connections/* > "$file1""

sudo bash -c "cut -c 40-70 < "$file1" |tee "$file2"" 
cat $file2 | xargs nmcli connection delete


sudo bash -c "rm -f "$file1""
sudo bash -c "rm -f "$file2""
