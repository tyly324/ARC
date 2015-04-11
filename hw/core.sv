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

//fetch
wire 








fetch u_fetch(
	.i_clk(clk),
	.i_nrst(rst_n),
	.i_addr_b(if_addr_b),
	.i_addr_j(if_addr_j),
	.i_addr_jr(if_addr_jr),
	.i_con_b(if_con_b),
	.i_con_j(if_con_j),
	.i_data_instr(if_data_instr),

	.o_addr_pc(),
	.o_data_instr()
	);


decode u_decode(
	.i_clk(clk),
	.i_nrst(rst_n),
	.i_addr_pc4(id_addr_pc4),
	.i_data_instr(id_data_instr),
	.i_con_Wregwrite(id_con_Wregwrite),
	.i_data_Wregwrite(id_data_Wregwrite),
	.i_addr_Wregwrite(id_addr_Wregwrite),

	//registers
	.o_data_rs,
	.o_data_rt,
	.o_addr_rd,
	.o_addr_rt,
	.o_addr_rs,
	//pc
	.o_con_ifbranch,
	.o_con_jump,
	.o_addr_pc4,
	.o_addr_pcadd,
	.o_addr_jump,
	//control
	.o_con_Ealuop,
	.o_con_Ealusrc,
	.o_con_Eregdst,
	.o_con_Ealupc4,
	.o_con_Mmemread,
	.o_con_Mmemwrite,
	.o_con_Wloadmux,
	.o_con_Wmemtoreg,
	.o_con_Wregwrite
	);


execute u_execute(
	.i_clk(clk),
	.i_nrst(rst_n),
	.i_data_pc4(ex_data_pc4),
	.i_data_rs(ex_data_rs),
	.i_data_rt(ex_data_rt),
	.i_data_immext(ex_data_immext),
	.i_addr_rs(ex_addr_rs),
	.i_addr_rt(ex_addr_rt),
	.i_addr_rd(ex_addr_rd),
	//forward
	.i_data_FEalures(ex_data_FEalures),
	.i_data_FMalures(ex_data_FMalures),
	.i_addr_FMregdst(ex_addr_FMregdst),
	.i_addr_FWregdst(ex_addr_FWregdst),
	.i_con_FMregwrite(ex_con_FMregwrite),
	.i_con_FWregwrite(ex_con_FWregwrite),
	//control
	.i_con_Ealuop(ex_con_Ealuop),
	.i_con_Ealusrc(ex_con_Ealusrc),
	.i_con_Eregdst(ex_con_Eregdst),
	.i_con_Ealupc4(ex_con_Ealupc4),
	.i_con_Mmemread(ex_con_Mmemread),
	.i_con_Mmemwrite(ex_con_Mmemwrite),
	.i_con_Wloadmux(ex_con_Wloadmux),
	.i_con_Wmemtoreg(ex_con_Wmemtoreg),
	.i_con_Wregwrite(ex_con_Wregwrite),

	.o_data_alures,
	.o_data_rt,
	.o_addr_regdst,
	.o_con_Mmemread,
	.o_con_Mmemwrite,
	.o_con_Wloadmux,
	.o_con_Wmemtoreg,
	.o_con_Wregwrite
	);


mem(
	.i_clk(clk),
	.i_rst_n(rst_n),

	.i_con_mem_branch(mem_con_mem_branch),
	.i_con_wb_memtoreg(mem_con_wb_memtoreg),
	.i_con_wb_regwrite(mem_con_wb_regwrite),
	.i_con_Zero(mem_con_Zero),
	.i_data_ALU_Rst,
	.i_addr_MuxRst,
	.i_data_Memory, //input data from data memory

	.o_con_wb_memtoreg,
	.o_con_wb_regwrite,
	.o_con_PCSrc,
	.o_data_Memory,
	.o_data_ALU_Rst,
	.o_addr_MuxRst
);



write_back(
	.i_con_wb_memtoreg,
	.i_data_Memory,
	.i_data_ALU_Rst,
	.o_data_MuxRst

);