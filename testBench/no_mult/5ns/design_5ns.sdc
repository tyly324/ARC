###################################################################

# Created by write_sdc on Fri Apr 24 02:35:31 2015

###################################################################
set sdc_version 1.9

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_max_area 0
create_clock [get_ports clk]  -period 5  -waveform {0 2.5}
