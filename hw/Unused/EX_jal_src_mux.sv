module EX_jal_src_mux(
						input  [31:0] i_data_PCplus4, i_data_rs, 
             		  	input         i_con_jal, 
               			output [31:0] o_data_alusrcA);

	assign o_data_alusrcA = i_con_jal ? i_data_PCplus4 : i_data_rs;

endmodule