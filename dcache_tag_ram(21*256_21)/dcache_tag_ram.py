"""
dcache tag ram
dual port (1 read only and 1 write only ) 21/32 kbytes SRAM with byte write.

FIXME: What is this useful for?
FIXME: Why would you want byte write on this?
"""
word_size = 21 # Bits
num_words = 256
human_byte_size = "{:.0f}kbytes".format((word_size * num_words)/1024/8)

# Allow byte writes
write_size = 21 # Bits

# Dual port
num_rw_ports = 0
num_r_ports = 1
num_w_ports = 1
ports_human = '1r_1w'

#output_name = "icache_data_ram"
import os
exec(open(os.path.join(os.path.dirname(__file__), 'sky130_sram_common.py')).read())
