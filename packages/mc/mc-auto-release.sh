#!/bin/sh
#Online auto release version finder by KuLuSz
#Required: GLib-2.56.1 and PCRE-8.42
#Recommended:  slang-2.3.2
#Optional: Doxygen-1.8.14, GPM-1.20.7, Samba-4.8.0, UnZip-6.0, X Window System, and Zip-3.0 

wget -q -O /tmp/mc-page.html http://midnight-commander.org/
MCVERSION=$(cat /tmp/mc-page.html | grep -i "current version" | cut -f1 -d';' | awk -F' ' {print $4})
wget -c -N --progress=bar:force --content-disposition --trust-server-names https://github.com/MidnightCommander/mc/archive/$MCVERSION.tar.gz
rm /tmp/mc-page.html

./configure --prefix=/usr \
            --sysconfdir=/etc \
            --enable-charset
make

make install DESTDIR=mc-$MCVERSION
cp -v doc/keybind-migration.txt mc-$MCVERSION/usr/share/mc
