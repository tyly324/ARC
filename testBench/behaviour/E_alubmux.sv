`timescale 1ns / 1ps
module E_alubmux(
	input logic [31:0] i_data_fb, 
	input logic [31:0] i_data_imm,
	input logic i_con_imm,
	output logic [31:0] o_data_alub
	);

assign o_data_alub = i_con_imm ? i_data_imm : i_data_fb;

endmodule