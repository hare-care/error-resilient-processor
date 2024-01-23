#!/bin/sh
export OPENRAM_TECH="/home/sfs6562/OpenRAM/technology:/home/sfs6562/OpenRAM/miniconda/lib/python3.8/site-packages/openram/technology"
echo "$(date): Starting LVS using Netgen /home/sfs6562/OpenRAM/miniconda/bin/netgen"
/home/sfs6562/OpenRAM/miniconda/bin/netgen -noconsole << EOF
lvs {icache_tag_ram.spice icache_tag_ram} {icache_tag_ram.lvs.sp icache_tag_ram} setup.tcl icache_tag_ram.lvs.report -full -json
quit
EOF
magic_retcode=$?
echo "$(date): Finished ($magic_retcode) LVS using Netgen /home/sfs6562/OpenRAM/miniconda/bin/netgen"
exit $magic_retcode
