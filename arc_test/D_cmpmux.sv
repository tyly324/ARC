module D_cmpmux(
	input logic [31:0] i_data_rs,
	input logic [31:0] i_data_aluresE,
	input logic i_con_cmpalu,
	output logic [31:0] o_data_cmprs
	);

assign o_data_cmprs = i_con_cmpalu ? i_data_aluresE : i_data_rs;

endmodule