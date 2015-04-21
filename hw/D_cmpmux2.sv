module D_cmpmux2(
	input logic [31:0] i_data_rs,
	input logic [31:0] i_data_memout,
	input logic i_con_cmpmem,
	output logic [31:0] o_data_cmprs
	);

assign o_data_cmprs = i_con_cmpmem ? i_data_memout : i_data_rs;

endmodule