////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: Zhiyuan Jiang
// Module: write_back
// Description: The first stage in pipleline, 
// 				write the result into a register.
//
// Vision: Ver 1.0.1 - First version
// Comments: 
//
////////////////////////////////////////////////
module write_back(
	input i_con_wb_memtoreg,
	input [31:0] i_data_Memory,
	input [31:0] i_data_ALU_Rst,

	output [31:0] o_data_MuxRst

);

WB_resmux u_wb_resmux(	.i_data_aluresW(i_data_ALU_Rst), 
						.i_data_readW(i_data_Memory), 
               			.i_con_memtoreg(i_con_wb_memtoreg), 
               			.o_data_result(o_data_MuxRst)
);

endmodule