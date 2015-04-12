`timescale 1ns / 1ps
module E_aluamux(
	input logic [31:0] i_data_fa, 
	input logic [31:0] i_data_pc4,
	input logic i_con_jump,
	output logic [31:0] o_data_alua
	);

assign o_data_alua = i_con_jump ? i_data_pc4 : i_data_fa;

endmodule