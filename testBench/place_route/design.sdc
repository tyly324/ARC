###################################################################

# Created by write_sdc on Wed Apr 22 23:01:23 2015

###################################################################
set sdc_version 1.8

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_max_area 0
create_clock [get_ports clk]  -period 3.85  -waveform {0 1.925}
