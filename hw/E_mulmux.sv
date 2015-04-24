module E_mulmux(
	output o_con_regwrite,
	input i_con_regwrite, 
	input i_con_mul);


	assign o_con_regwrite = i_con_mul ? 0:i_con_regwrite;

	endmodule
