module D_fmemmux(
	input logic [31:0] i_data_Mmemout,
	input logic [31:0] i_data_Wmemout,
	input logic i_con_fmem,
	output logic [31:0] o_data_fmem
	);

assign o_data_fmem = i_con_fmem ? i_data_Wmemout : i_data_Mmemout;

endmodule