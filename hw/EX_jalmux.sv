module EX_jalmux(	input  [4:0] i_reg_td, 
               		input  i_con_jal, 
              	 	output [4:0] o_reg_writeRegD);

  assign o_reg_writeRegD = i_con_jal ? 31 : i_reg_td; 

endmodule