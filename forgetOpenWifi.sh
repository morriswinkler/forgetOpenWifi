#!/bin/bash

# variables
file1=/home/$USER/file1.txt
file2=/home/$USER/file2.txt
file2new=/home/$USER/file2new.txt
file3=/home/$USER/file3.txt
file4=/home/$USER/file4.txt
file5=/home/$USER/file5.txt

# shutdown networking
sudo bash -c "nmcli networking off"


# grep all unencrypted wifi connections and write it to file1
sudo bash -c "grep -L "psk=" /etc/NetworkManager/system-connections/* > "$file1""


# remove absolute pathnames inside file1 and write output to file2
sudo bash -c "cut -c 40-70 "$file1" > "$file2""


# sourround all lines in file2 with apostrophes and write it to file2new
sed -e "s/\(.*\)/'\1'/" $file2 > $file2new


# show more information for unencrypted wifi connections and write it to file3
sudo bash -c "cat $file2new | xargs nmcli con show > "$file3" 2> /dev/null"  


# for each result find uuid and write it to file4
sudo bash -c "grep uuid $file3 > "$file4" 2> /dev/null"


# remove unwanted characters from file4 and write it to file5  
sudo bash -c "cut -c 17-80 "$file4" > "$file5""



# for each uuid in file5 delete connection
sudo bash -c "cat $file5 | xargs nmcli connection delete 2> /dev/null"


# removes temp files
sudo bash -c "rm -f "$file1""
sudo bash -c "rm -f "$file2""
sudo bash -c "rm -f "$file2new""
sudo bash -c "rm -f "$file3""
sudo bash -c "rm -f "$file4""
sudo bash -c "rm -f "$file5""

# show network connections
nmcli connection show

# start networking
sudo bash -c "nmcli networking on"


exit $?
