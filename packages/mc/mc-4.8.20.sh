#Required: GLib-2.56.1 and PCRE-8.42
#Recommended:  slang-2.3.2
#Optional: Doxygen-1.8.14, GPM-1.20.7, Samba-4.8.0, UnZip-6.0, X Window System, and Zip-3.0 


wget -c -N --progress=bar:force --content-disposition --trust-server-names https://github.com/MidnightCommander/mc/archive/4.8.20.tar.gz


./configure --prefix=/usr \
            --sysconfdir=/etc \
            --enable-charset
make

make install DESTDIR=mc-4.8.20
cp -v doc/keybind-migration.txt mc-4.8.20/usr/share/mc
