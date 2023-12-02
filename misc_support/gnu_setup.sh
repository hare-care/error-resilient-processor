setenv LD_LIBRARY_PATH /home/ece393/tools/lib
mkdir ~/opt
mkdir ~/opt/riscv
git clone https://github.com/riscv-collab/riscv-gnu-toolchain.git
#git clone git@github.com:riscv-collab/riscv-gnu-toolchain.git
cd ~/riscv-gnu-toolchain/
setenv PATH $PATH\:~/opt/riscv/bin
./configure --prefix=../opt/riscv --with-arch=rv32gc --with-abi=ilp32d
make clean
make
unsetenv LD_LIBRARY_PATH
