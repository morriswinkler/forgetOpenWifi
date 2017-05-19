#!/bin/bash

# variables
file1=/home/$USER/file1.txt
file2=/home/$USER/file2.txt
file2new=/home/$USER/file2new.txt
file3=/home/$USER/file3.txt
file4=/home/$USER/file4.txt
file5=/home/$USER/file5.txt



# grep all unencrypted wifi connections and write it to file1
sudo bash -c "grep -L "psk=" /etc/NetworkManager/system-connections/* > "$file1""


# remove absolute pathnames inside file1 and write output to file2
sudo bash -c "cut -c 40-70 < "$file1" |tee "$file2""


# sourround all lines in file2 with apostrophes and write it to file2new
sed -e "s/\(.*\)/'\1'/" $file2 > $file2new


# show more information for unencrypted wifi connections and write it to file3
sudo bash -c "cat $file2new | xargs nmcli con show > "$file3" 2> /dev/null"  


# for each result find uuid and write it to file4
sudo bash -c "cat $file3 | grep uuid | tee "$file4""


# remove unwanted characters from file4 and write it to file5  
sudo bash -c "cut -c 17-80 < "$file4" |tee "$file5""


# surround all lines in file5 with apostrophes
sed -e "s/\(.*\)/'\1'/" $file5


# for each uuid in file5 delete connection
sudo bash -c "cat $file5 | xargs nmcli connection delete"


# removes temp files
sudo bash -c "rm -f "$file1""
sudo bash -c "rm -f "$file2""
sudo bash -c "rm -f "$file2new""
sudo bash -c "rm -f "$file3""
sudo bash -c "rm -f "$file4""
sudo bash -c "rm -f "$file5""

exit $?
