////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: 
// Module: 
// Description: 
//
// Vision: Ver 1.0.0 - File Create
// Comments: 
//
////////////////////////////////////////////////
module core(input logic clk, )

fetch fetch_inst(
	.i_clk					(clk),
	.i_addr_AddRst			(io_),
	.i_con_PCSrc			(),
	.i_data_Instr			(),
	.o_data_Instr			(),
	.o_addr_NextPC			(),
	.o_addr_PC				()
	)

decode decode_inst(
	.i_clk					(clk),
	.i_con_RegWr			(),
	.i_addr_NextPC			(),
	.i_data_Instr			(),
	.i_addr_WrReg			(),
	.i_data_WrData			(),

	//control
	.o_con_ex_regdst		(),
	.o_con_mem_branch		(),
	.o_con_mem_memread		(),
	.o_con_wb_memtoreg		(),
	.o_con_mem_memwrite		(),
	.o_con_ex_alusrc		(),
	.o_con_wb_regwrite		(),
	.o_con_ex_aluop			(),
	//Next PC
	.o_addr_NextPC			(),
	// registers
	.o_data_rs				(),
	.o_data_rt				(),
	//sign-extend
	.o_data_SignExt			(),
	//rd address
	.o_addr_mux_0			(),
	.o_addr_mux_1			()
	)

execute execute_inst(
	.i_clk					(clk),
	//control
	.i_con_ex_regdst		(),	
	.i_con_mem_branch		(),
	.i_con_mem_memread		(),
	.i_con_wb_memtoreg		(),
	.i_con_mem_memwrite		(),
	.i_con_ex_alusrc		(),
	.i_con_wb_regwrite		(),
	.i_con_ex_aluop			(),
	//Next PC
	.i_addr_NextPC			(),
	// registers
	.i_data_rs				(),
	.i_data_rt				(),
	//sign-extend
	.i_data_SignExt			(),
	//rd address
	.i_addr_mux_0			(),
	.i_addr_mux_1			(),

	.o_con_mem_branch		(),
	.o_con_mem_memread		(),
	.o_con_wb_memtoreg		(),
	.o_con_mem_memwrite		(),
	.o_con_wb_regwrite		(),

	.o_data_AddRst			(),
	.o_con_Zero				(),
	.o_data_ALU_Rst			(),
	.o_data_rt				(),
	.o_addr_MuxRst			()
	)