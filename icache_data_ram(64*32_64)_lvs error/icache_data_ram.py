"""
icache data ram
Single port (1 read/write ) 8 kbytes SRAM with byte write.

FIXME: What is this useful for?
FIXME: Why would you want byte write on this?
"""
""" 64,128,8,1,1 fails, netlist mismatch 
    64,128,8,2,0,0 fails, netlist mismatch
    32,128,32,0,1,1 success
 """
word_size = 64 # Bits,should be 64
num_words = 32  #original 128
human_byte_size = "{:.0f}kbytes".format((word_size * num_words)/1024/8)

# Allow byte writes
write_size = 64 # Bits, should be 64

# Dual port
num_rw_ports = 0 #should be 1
num_r_ports = 1
num_w_ports = 1
ports_human = '1rw'

num_spare_cols = 0
num_spare_rows = 0
#output_name = "icache_data_ram"
import os
exec(open(os.path.join(os.path.dirname(__file__), 'sky130_sram_common.py')).read())
