`timescale 1ns / 1ps
module M_resmux(
	input logic [31:0] i_data_alures, 
	input logic [31:0] i_data_pc8, 
	input logic i_con_pc8, 
	output logic [31:0] o_data_alu
	);

  assign o_data_alu = i_con_pc8 ? i_data_pc8 : i_data_alures; 

endmodule

               
                                       
