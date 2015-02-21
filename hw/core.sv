////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: 
// Module: 
// Description: 
//
// Vision: Ver 1.0.0 - File Create
// Comments: 
//
////////////////////////////////////////////////
module core(
	input logic clk,
	input logic [31:0] read_instruction,
	input logic [31:0] read_data,

	output logic [31:0] instruction_address,
	output logic [31:0] data_address,
	output logic [31:0] write_data
	)

wire [31:0] add_result;
wire 


fetch u_fetch(
	.i_clk(clk),
	.i_addr_AddRst(add_result),
	.i_con_PCSrc(),
	.i_data_Instr,
	
	.o_data_Instr,
	.o_addr_NextPC,
	.o_addr_PC
);