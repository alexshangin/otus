yum install -y zlib-devel gcc make git autoconf autogen automake pkgconfig psmisc libuuid-devel
git clone https://github.com/firehol/netdata.git --depth=1
cd netdata/
./netdata-installer.sh
