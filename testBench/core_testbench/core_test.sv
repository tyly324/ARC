timeunit 1ns; timeprecision 10ps;
module core_test;
logic clk;
logic [31:0] read_instruction, read_data, instruction_address, data_address, write_data;

core core_inst(.*);

  initial 
  begin
    clk = 0;
    forever #10ns clk = ~clk;
  end

  initial
  begin
  	read_instruction = 
  	read_data = 00000000;
