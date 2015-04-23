###################################################################

# Created by write_sdc on Thu Apr 23 21:50:00 2015

###################################################################
set sdc_version 1.9

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_max_area 0
create_clock [get_ports clk]  -period 6  -waveform {0 3}
