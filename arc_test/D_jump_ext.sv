`timescale 1ns / 1ps
module D_jump_ext(
	input logic [25:0] i_addr_j,
	input logic [3:0] i_PC4_j,//*********
	output logic [31:0] o_addr_j
	);

assign o_addr_j = {i_PC4_j, i_addr_j, 2'b00};

endmodule