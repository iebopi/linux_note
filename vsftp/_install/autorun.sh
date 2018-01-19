ipEth0=$(xmllint --xpath "//Root/InIP/text()" /opt/SeedingController/config/bootConfig.xml)
ipEth1=$(xmllint --xpath "//Root/OutIP/text()" /opt/SeedingController/config/bootConfig.xml)
if [[ $ipEth0 = "" ]]; then ipEth0=192.168.1.99; fi
if [[ $ipEth0 = "" ]]; then ipEth0=192.168.2.99; fi

ifconfig eth0 $ipEth0
ifconfig eth1 $ipEth1

route add default gw ${ipEth0%.*}.1 dev eth0
route add default gw ${ipEth1%.*}.1 dev eth1

#sleep 10
chown root:root /etc/vsftpd.conf
mkdir -p /usr/share/empty
passwd << EOF
root
root
EOF
vsftpd &

mkdir -p /opt/SeedingController/config
mkdir -p /opt/SeedingController/media
chmod 777 -R /opt/SeedingController/*
cd /opt/SeedingController/
./ts_deamon &

echo "done!"

