`timescale 1ns / 1ps
module D_unsign_extend(
	input logic [25:0] i_addr_j,
	output logic [31:0] o_addr_j
	);

assign o_addr_j = {6'b0,i_addr_j};

endmodule