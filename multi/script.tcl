

analyze -format sverilog {./multiply_a.sv }

elaborate multiply_a

create_clock clock -name clock -period 4 
compile
set_max_area 0
