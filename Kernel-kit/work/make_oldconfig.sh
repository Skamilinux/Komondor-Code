SRC_DIR=$(pwd)

JOB_FACTOR="$(grep -i ^JOB_FACTOR .config | cut -f2 -d'=')"
NUM_CORES=$(grep ^processor /proc/cpuinfo | wc -l)
NUM_JOBS=$((NUM_CORES * JOB_FACTOR))

if [ ! -f .config ] ; then
  echo "Config file .config does not exist."
fi

#change dir to linux like e.g. linux-4.16.13
cd $(ls -d linux-*)

#initialize
echo "Preparing kernel work area..."
make mrproper -j $NUM_JOBS

# make oldconfig ???? ....later maybe....

echo "Building kernel..."
make \
  CFLAGS="-Os -s -fno-stack-protector -U_FORTIFY_SOURCE" \
  bzImage -j $NUM_JOBS


make INSTALL_MOD_PATH="$SRC_DIR/work/kernel/kernel_installed" modules_install


# Install the kernel file.
cp arch/x86/boot/bzImage \
  $SRC_DIR/work/kernel/kernel_installed/vmlinuz

# Install kernel headers which are used later when we build and configure the
# GNU C library (glibc).
echo "Generating kernel headers..."
make \
  INSTALL_HDR_PATH=$SRC_DIR/work/kernel/kernel_installed \
  headers_install -j $NUM_JOBS

cd $SRC_DIR
