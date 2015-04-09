`timescale 1ns / 1ps
module E_aluamux(
	input logic [31:0] i_data_pc4, 
	input logic [31:0] i_data_fa,
	input logic i_con_alua,
	input logic [31:0] o_data_alua
	);

o_data_alua = i_con_alua ? i_data_fa : i_data_pc4;

endmodule