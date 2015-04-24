
`timescale 1ns / 1ps
/*module mulf (
	input logic [15:0]A, [15:0]B_a, [7:0]B_b, [7:0]B_c, 
	[15:0]C_a, [7:0]C_b, [7:0]C_c,
	output logic [31:0]D);

assign D = A + {B_a, B_b, B_c} + {C_a, C_b, C_c};

endmodule*/

module E_mulf (
	input logic [15:0]B_a, [7:0]B_b, [7:0]B_c, 
	[15:0]C_a, [7:0]C_b, [7:0]C_c,
	output logic [31:0]D);

assign D ={B_a, B_b, B_c} + {C_a, C_b, C_c};

endmodule
