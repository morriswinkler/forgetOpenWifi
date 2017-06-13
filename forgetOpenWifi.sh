# set variables
a=/tmp/1.txt
b=/tmp/2.txt
c=/tmp/3.txt
d=/tmp/4.txt
e=/tmp/5.txt
f=/tmp/6.txt
g=/tmp/7.txt
h=/tmp/8.txt
i=/tmp/9.txt
j=/tmp/a.txt

# shutdown networking
nmcli networking off 2> /dev/null

# grep all networks without encryption 
sudo grep -L "psk=" /etc/NetworkManager/system-connections/* > $a

# remove absolute pathnames from output
cut -c 40-70 $a > $b

# get all ethernet networks
nmcli --fields NAME,TYPE connection | grep 802-3.ethernet > $c

# remove string from output
sed 's/802-3-ethernet//g' $c > $d

# join the two lists and keep only wifi connections without encryption
join -v 1 <(sort $b) <(sort $d) > $e

# sourround all lines in output with apostrophes
sed -e "s/\(.*\)/'\1'/" $e > $f

# show more information for unencrypted wifi connections
cat $f | xargs nmcli con show > $g 2> /dev/null

# for each unencrypted wifi connection find uuid
grep uuid $g > $h 2> /dev/null

# remove string from output
cut -c 17-80 $h > $i

# remove white spaces
cut -c 25-80 $i > $j

# delete connections with uuid
cat $j | xargs nmcli connection delete 2> /dev/null

# remove temp files
rm -f $a
rm -f $b
rm -f $c
rm -f $d
rm -f $e
rm -f $f
rm -f $g
rm -f $h
rm -f $i
rm -f $j

# show network connections
nmcli connection show

# start networking
nmcli networking on 2> /dev/null


exit $?
