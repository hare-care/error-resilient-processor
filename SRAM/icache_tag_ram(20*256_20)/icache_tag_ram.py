"""
icache tag ram
Single port (1 read/write ) 5/8 kbytes SRAM with byte write.

FIXME: What is this useful for?
FIXME: Why would you want byte write on this?
"""

word_size = 20 # Bits should be 20
num_words = 256  #original 256
human_byte_size = "{:.0f}kbytes".format((word_size * num_words)/1024/8)

# Allow byte writes
write_size = 20 # Bits

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
