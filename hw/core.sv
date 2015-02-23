////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: Zhiyuan Jiang
// Module: core
// Description: Top-level of the processor
//
// Vision: Ver 1.0.2 - Add reset signal
// Comments: 
//
////////////////////////////////////////////////
module core(
	input logic clk,
	input logic rst_n,
	input logic [31:0] read_instruction,
	input logic [31:0] read_data,

	output logic [31:0] instruction_address,
	output logic [31:0] data_address,
	output logic [31:0] write_data,
	output logic mem_write,
	output logic mem_read
	);

assign instruction_address = if_addr_PC;
assign data_address = ex_data_ALU_Rst;
assign write_data = ex_data_rt;
assign mem_write = ex_con_mem_memwrite;
assign mem_read = ex_con_mem_memread;

fetch u_fetch(
	.i_clk(clk),
	.i_rst_n(i_rst_n),
	.i_addr_AddRst(ex_data_AddRst),
	.i_con_PCSrc(mem_control_PCSrc),
	.i_data_Instr(read_instruction),
	
	.o_data_Instr(if_data_Instr),
	.o_addr_NextPC(if_addr_NextPC),
	.o_addr_PC(if_addr_PC)
);


decode u_decode(
	.i_clk(clk),
	.i_rst_n(i_rst_n),
	.i_con_RegWr(mem_con_wb_regwrite),
	.i_addr_NextPC(if_addr_NextPC),
	.i_data_Instr(if_data_Instr),
	.i_addr_WrReg(mem_addr_MuxRst),
	.i_data_WrData(wb_data_MuxRst),

	.o_con_ex_regdst(id_con_ex_regdst),
	.o_con_mem_branch(id_con_mem_branch),
	.o_con_mem_memread(id_con_mem_memread),
	.o_con_wb_memtoreg(id_con_wb_memtoreg),
	.o_con_mem_memwrite(id_con_mem_memwrite),
	.o_con_ex_alusrc(id_con_ex_alusrc),
	.o_con_wb_regwrite(id_con_wb_regwrite),
	.o_con_ex_aluop(id_con_ex_aluop),
	.o_addr_NextPC(id_addr_NextPC),
	.o_data_rs(id_data_rs),
	.o_data_rt(id_data_rt),
	.o_data_SignExt(id_data_SignExt),
	.o_addr_mux_0(id_addr_mux_0),
	.o_addr_mux_1(id_addr_mux_1),
	.o_data_shamt(id_data_shamt)	//(added on 12:45 23/02/2015 by hy7g14 )
);


execute u_execute(
	.i_clk(clk),
	.i_rst_n(i_rst_n),
	.i_con_ex_regdst(id_con_ex_regdst),
	.i_con_mem_branch(id_con_mem_branch),
	.i_con_mem_memread(id_con_mem_memread),
	.i_con_wb_memtoreg(id_con_wb_memtoreg),
	.i_con_mem_memwrite(id_con_mem_memwrite),
	.i_con_ex_alusrc(id_con_ex_alusrc),
	.i_con_wb_regwrite(id_con_wb_regwrite),
	.i_con_ex_aluop(id_con_ex_aluop),
	.i_addr_NextPC(id_addr_NextPC),
	.i_data_rs(id_data_rs),
	.i_data_rt(id_data_rt),
	.i_data_SignExt(id_data_SignExt),
	.i_addr_mux_0(id_addr_mux_0),
	.i_addr_mux_1(id_addr_mux_1),
	.i_data_shamt(id_data_shamt),	//(added on 12:45 23/02/2015 by hy7g14 )

	.o_con_mem_branch(ex_con_mem_branch),
	.o_con_mem_memread(ex_con_mem_memread),
	.o_con_wb_memtoreg(ex_con_wb_memtoreg),
	.o_con_mem_memwrite(ex_con_mem_memwrite),
	.o_con_wb_regwrite(ex_con_wb_regwrite),

	.o_data_AddRst(ex_data_AddRst),
	.o_con_Zero(ex_con_Zero),
	.o_data_ALU_Rst(ex_data_ALU_Rst),
	.o_data_rt(ex_data_rt),
	.o_addr_MuxRst(ex_addr_MuxRst)

	);

mem u_mem(
	.i_clk(clk),
	.i_rst_n(i_rst_n),
	.i_con_mem_branch(ex_con_mem_branch),
	.i_con_wb_memtoreg(ex_con_wb_memtoreg),
	.i_con_wb_regwrite(ex_con_wb_regwrite),
	.i_con_Zero(ex_con_Zero),
	.i_data_ALU_Rst(ex_data_ALU_Rst),
	.i_addr_MuxRst(ex_addr_MuxRst),
	.i_data_Memory(read_data), //input data from data memory

	.o_con_wb_memtoreg(mem_con_wb_memtoreg),
	.o_con_wb_regwrite(mem_con_wb_regwrite),
	.o_con_PCSrc(mem_con_PCSrc),
	.o_data_Memory(mem_data_Memory),
	.o_data_ALU_Rst(mem_data_ALU_Rst),
	.o_addr_MuxRst(mem_addr_MuxRst)
);

write_back u_write_back(
	.i_con_wb_memtoreg(mem_con_wb_memtoreg),
	.i_data_Memory(mem_data_Memory),
	.i_data_ALU_Rst(mem_data_ALU_Rst),

	.o_data_MuxRst(wb_data_MuxRst)
);

endmodule