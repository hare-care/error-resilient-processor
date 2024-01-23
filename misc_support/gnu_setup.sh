setenv LD_LIBRARY_PATH /home/ece393/tools/lib
mkdir /home/kcr1868/opt
mkdir /home/kcr1868/opt/riscv
cd /home/kcr1868
git clone https://github.com/riscv-collab/riscv-gnu-toolchain.git
#git clone git@github.com:riscv-collab/riscv-gnu-toolchain.git
cd /home/kcr1868/riscv-gnu-toolchain/
setenv PATH $PATH\:/home/kcr1868/opt/riscv/bin
./configure --prefix=/home/kcr1868/opt/riscv --with-arch=rv32gc --with-abi=ilp32d
make clean
make
unsetenv LD_LIBRARY_PATH
