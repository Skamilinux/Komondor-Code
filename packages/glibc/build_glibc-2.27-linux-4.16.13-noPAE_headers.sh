#!/bin/sh

JOB_FACTOR="$(grep -i ^JOB_FACTOR .config | cut -f2 -d'=')"
NUM_CORES=$(grep ^processor /proc/cpuinfo | wc -l)
NUM_JOBS=$((NUM_CORES * JOB_FACTOR))
CFLAGS=-Os -s -fno-stack-protector -fomit-frame-pointer -U_FORTIFY_SOURCE

set -e

cd glibc_objects

echo "Configuring glibc."

./configure \
  --prefix= \
  --with-headers=../../../linux-4.16.13-noPAE/kernel_installed/include \
  --disable-werror \
  CFLAGS="$CFLAGS"

# Compile glibc with optimization for "parallel jobs" = "number of processors".
echo "Building glibc."
make -j $NUM_JOBS

# Install glibc in the installation area, e.g. 'work/glibc/glibc_installed'.
echo "Installing glibc."
make install DESTDIR=glibc_installed -j $NUM_JOBS 
