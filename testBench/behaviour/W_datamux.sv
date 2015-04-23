`timescale 1ns / 1ps
module W_datamux(
	input logic [31:0] i_data_alu, 
	input logic [31:0] i_data_load,
	input logic i_con_memtoreg,
	output logic [31:0] o_data_toreg
	);

assign o_data_toreg = i_con_memtoreg ? i_data_load : i_data_alu;

endmodule