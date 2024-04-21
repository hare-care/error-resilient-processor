setenv LD_LIBRARY_PATH
setenv LD_LIBRARY_PATH /home/ece393/tools/lib:/home/ece393/tools/lib64:$LD_LIBRARY_PATH
setenv PATH /home/ece393/tools/bin:/home/ece393/oss-cad-suite/bin:/home/ece393/tools/klayout:$PATH
setenv PDK_ROOT /home/ece393/open_pdks/share/pdk
python3.9 -m openlane /home/kcr1868/openlane_config_example.json --pdk-root openlane/
