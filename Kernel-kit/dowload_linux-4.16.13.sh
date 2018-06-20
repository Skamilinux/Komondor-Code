#download the kernel
wget -c -N --progress=bar:force --content-disposition --trust-server-names https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.16.13.tar.xz

#unpack the kernel
tar -xvf linux-4.16.13.tar.xz -C linux-4.16.13
