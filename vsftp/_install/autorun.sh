ifconfig eth1 10.21.1.99
ifconfig eth0 10.21.1.98
#sleep 10
chown root:root /etc/vsftpd.conf
mkdir -p /usr/share/empty
passwd << EOF
root
root
EOF

vsftpd &
echo "done!"