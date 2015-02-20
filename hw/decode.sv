////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: Zhiyuan Jiang
// Module: decode
// Description: The second stage in pipleline, 
// 				decode the instruction and read
//				data from registers bank.
//
// Vision: Ver 1.0.1 - Add content
// Comments: 
//
////////////////////////////////////////////////
module decode(
	input i_clk,
	input i_con_WrBack,
	input i_con_Mem,
	input i_con_Exe,
	input [31:0] i_addr_IncrePC,
	input [31:0] i_data_Rs,
	input [31:0] i_data_Rt,
	input [31:0] i_data_SignExt,
	);