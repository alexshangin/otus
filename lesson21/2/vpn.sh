#! /usr/bin/env bash
yum install -y epel-release
yum install -y openvpn easy-rsa mc
cd /etc/openvpn/
/usr/share/easy-rsa/3.0.6/easyrsa init-pki
#generate key4server
echo 'rasvpn' | /usr/share/easy-rsa/3.0.6/easyrsa build-ca nopass
echo 'rasvpn' | /usr/share/easy-rsa/3.0.6/easyrsa gen-req server nopass
echo 'yes' | /usr/share/easy-rsa/3.0.6/easyrsa sign-req server server
/usr/share/easy-rsa/3.0.6/easyrsa gen-dh
openvpn --genkey --secret ta.key
#generate key4client
echo 'client' | /usr/share/easy-rsa/3/easyrsa gen-req client nopass
echo 'yes' | /usr/share/easy-rsa/3/easyrsa sign-req client client
echo 'iroute 192.168.100.0 255.255.255.0' > /etc/openvpn/client/client
mv /vagrant/server.conf /etc/openvpn/server.conf
#disable SELinux
setenforce Permissive
#start openvpn
systemctl start openvpn@server
systemctl enable openvpn@server
#copy key for copy on host
cp /etc/openvpn/pki/ca.crt /opt/ca.crt
cp /etc/openvpn/pki/issued/client.crt /opt/client.crt
cp /etc/openvpn/pki/private/client.key /opt/client.key
chmod -R 0777 /opt/
