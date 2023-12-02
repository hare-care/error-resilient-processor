setenv LD_LIBRARY_PATH /home/ece393/tools/lib
mkdir $HOME/opt
mkdir $HOME/opt/riscv
cd $HOME
git clone https://github.com/riscv-collab/riscv-gnu-toolchain.git
#git clone git@github.com:riscv-collab/riscv-gnu-toolchain.git
cd $HOME/riscv-gnu-toolchain/
setenv PATH $PATH\:$HOME/opt/riscv/bin
./configure --prefix=../opt/riscv --with-arch=rv32gc --with-abi=ilp32d
make clean
make
unsetenv LD_LIBRARY_PATH
