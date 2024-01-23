"""
dcache data ram
DUal port (2 read/write ) 8 kbytes SRAM with byte write.

FIXME: What is this useful for?
FIXME: Why would you want byte write on this?
"""
word_size = 32 # Bits
num_words = 128
human_byte_size = "{:.0f}kbytes".format((word_size * num_words)/1024/8)

# Allow byte writes
write_size = 4 # Bits

# Dual port
num_rw_ports = 2
num_r_ports = 0
num_w_ports = 0
ports_human = '2rw'

#num_spare_cols = 1
#num_spare_rows = 1
#output_name = "icache_data_ram"
import os
exec(open(os.path.join(os.path.dirname(__file__), 'sky130_sram_common.py')).read())
