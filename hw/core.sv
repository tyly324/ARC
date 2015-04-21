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
wire [31:0]if_addr_b;
wire [31:0]if_addr_j;
wire [31:0]if_addr_pc;
wire [1:0] if_con_j;  ////////////
//decode
wire [31:0]id_addr_pc4;
wire [31:0]id_data_instr;
wire [31:0]id_data_Wregwrite;
wire [4:0] id_addr_Wregwrite;
///////////////forward in decode/////////////////////
wire [2:0] for_o_con_Efamux;
wire [2:0] for_o_con_Efbmux;
wire [4:0] for_addr_rtM;
wire [4:0] for_addr_rtW;
wire [31:0] for_memout;
wire [31:0] for_aluresE;
//execute
wire [31:0] ex_data_pc4;
wire [31:0] id_data_rs;
wire [31:0] ex_data_rt;
wire [31:0] ex_data_immext;
wire [4:0] ex_addr_rt;
wire [4:0] ex_addr_rd;
wire [5:0] ex_con_Ealuop;
wire [1:0] ex_con_Wloadmux;
wire [31:0] ex_data_alures;
///////////////forward in execute/////////////////////
wire [4:0] for_o_addr_Erd;
//memory
wire [31:0] mem_data_pc4;
wire [31:0] mem_data_alures;
wire [4:0] mem_addr_regdst;
wire [1:0] mem_con_Wloadmux;
//write back
wire [31:0] wb_data_pc8;
wire [31:0] wb_data_memout;
wire [1:0] wb_con_Wloadmux;

wire if_con_b, id_con_Wregwrite, ex_con_Ealusrc,
ex_con_Eregdst, ex_con_Mmemread, ex_con_Mmemwrite, 
ex_con_Wmemtoreg, ex_con_Walupc8, ex_con_Wregwrite, 
mem_con_Walupc8, mem_con_Wregwrite, mem_con_Wmemtoreg, 
wb_con_Walupc8, wb_con_Wmemtoreg;



assign instruction_address = if_addr_pc;
assign data_address = ex_data_alures;


fetch u_fetch(
	.i_clk(clk),
	.i_nrst(rst_n),
	.i_addr_b(if_addr_b),
	.i_addr_j(if_addr_j),
	.i_addr_jr(id_data_rs),
	.i_con_b(if_con_b),
	.i_con_j(if_con_j),
	.i_data_instr(read_instruction),

	.o_addr_pc(if_addr_pc),
	.o_addr_pc4(id_addr_pc4),
	.o_data_instr(id_data_instr)
	);


decode u_decode(
	.i_clk(clk),
	.i_nrst(rst_n),
	.i_addr_pc4(id_addr_pc4),
	.i_data_instr(id_data_instr),
	.i_con_Wregwrite(id_con_Wregwrite),
	.i_data_Wregwrite(id_data_Wregwrite),
	.i_addr_Wregwrite(id_addr_Wregwrite),
	//forward/////////////////////////////////
	.i_addr_Erd(for_o_addr_Erd),
	.i_addr_Mrd(mem_addr_regdst),
	.i_con_Eregwrite(ex_con_Wregwrite),
	.i_con_Mregwrite(mem_con_Wregwrite),
	.i_addr_rtM(for_addr_rtM),/////////////
	.i_addr_rtW(for_addr_rtW),///////////
	.i_con_memreadM(mem_read),///////////
	.i_con_memreadW(for_FWmemread),/////////
	.i_data_aluresE(for_aluresE),//////////
	.i_data_memoutM(read_data),

	//registers
	.o_data_rs(id_data_rs),
	.o_data_rt(ex_data_rt),
	.o_addr_rd(ex_addr_rd),
	.o_addr_rt(ex_addr_rt),
	//.o_addr_rs(ex_addr_rs),/////////////////
	//pc
	.o_con_ifbranch(if_con_b),
	.o_con_jump(if_con_j),////////////////
	.o_addr_pc4(ex_data_pc4),
	.o_addr_pcadd(if_addr_b),
	.o_addr_jump(if_addr_j),
	//control
	.o_con_Ealuop(ex_con_Ealuop),
	.o_con_Ealusrc(ex_con_Ealusrc),
	.o_con_Eregdst(ex_con_Eregdst),
	.o_con_Mmemread(ex_con_Mmemread),
	.o_con_Mmemwrite(ex_con_Mmemwrite),
	.o_con_Wloadmux(ex_con_Wloadmux),
	.o_con_Walupc8(ex_con_Walupc8),/////////
	.o_con_Wmemtoreg(ex_con_Wmemtoreg),
	.o_con_Wregwrite(ex_con_Wregwrite),
	//data
	.o_data_signext(ex_data_immext),
	//forward unit/////////////////
	.o_con_Efamux(for_o_con_Efamux),
	.o_con_Efbmux(for_o_con_Efbmux),
	.o_data_Fmemout(for_memout)
	);


execute u_execute(
	.i_clk(clk),
	.i_nrst(rst_n),
	.i_data_pc4(ex_data_pc4),
	.i_data_rs(id_data_rs),
	.i_data_rt(ex_data_rt),
	.i_data_immext(ex_data_immext),
	//.i_addr_rs(ex_addr_rs),///////////////////
	.i_addr_rt(ex_addr_rt),
	.i_addr_rd(ex_addr_rd),
	//forward
	.i_data_FEalures(ex_data_alures),
	.i_data_FMalures(id_data_Wregwrite),
	.i_data_FMmemout(wb_data_memout),////////////
	.i_data_FWmemout(for_memout),////////////
	//control
	.i_con_Ealuop(ex_con_Ealuop),
	.i_con_Ealusrc(ex_con_Ealusrc),
	.i_con_Eregdst(ex_con_Eregdst),
	.i_con_Mmemread(ex_con_Mmemread),
	.i_con_Mmemwrite(ex_con_Mmemwrite),
	.i_con_Wloadmux(ex_con_Wloadmux),
	.i_con_Walupc8(ex_con_Walupc8),///////////
	.i_con_Wmemtoreg(ex_con_Wmemtoreg),
	.i_con_Wregwrite(ex_con_Wregwrite),
	//forward unit///////////////////
	.i_con_Efamux(for_o_con_Efamux),
	.i_con_Efbmux(for_o_con_Efbmux),

	.o_data_pc4(mem_data_pc4),//////////
	.o_data_alures(ex_data_alures),
	.o_data_rt(write_data),
	.o_addr_regdst(mem_addr_regdst),
	.o_con_Mmemread(mem_read),
	.o_con_Mmemwrite(mem_write),
	.o_con_Wloadmux(mem_con_Wloadmux),
	.o_con_Walupc8(mem_con_Walupc8),//////////////
	.o_con_Wmemtoreg(mem_con_Wmemtoreg),
	.o_con_Wregwrite(mem_con_Wregwrite),
	//forward feedback//////////////////////
	.o_addr_Erd(for_o_addr_Erd),
	.o_addr_Mrt(for_addr_rtM),
	.o_FaluresE(for_aluresE)
	);


mem u_mem(
	.i_clk(clk),
	.i_nrst(rst_n),
	.i_data_pc4(mem_data_pc4),///////////////
	.i_data_alures(ex_data_alures),
	.i_data_memout(read_data),
	.i_addr_regdst(mem_addr_regdst),
	.i_con_Wloadmux(mem_con_Wloadmux),
	.i_con_Walupc8(mem_con_Walupc8),/////////////
	.i_con_Wmemtoreg(mem_con_Wmemtoreg),
	.i_con_Wregwrite(mem_con_Wregwrite),
	.i_con_FWmemread(ex_con_Mmemread),////////////
	.i_addr_Mrt(for_addr_rtM),////////////////

	.o_data_pc8(wb_data_pc8),////////////
	.o_data_alures(mem_data_alures),
	.o_data_memout(wb_data_memout),
	.o_addr_regdst(id_addr_Wregwrite),
	//control
	.o_con_Wloadmux(wb_con_Wloadmux),
	.o_con_Walupc8(wb_con_Walupc8),///////////
	.o_con_Wmemtoreg(wb_con_Wmemtoreg),
	.o_con_Wregwrite(id_con_Wregwrite),
	//forward//////////////////////////////
	.o_con_FWmemread(for_FWmemread),
	.o_addr_Wrt(for_addr_rtW)
);



writeback u_writeback(
	.i_data_pc8(wb_data_pc8),////////////
	.i_data_alures(mem_data_alures),
	.i_data_memout(wb_data_memout),
	.i_con_Wloadmux(wb_con_Wloadmux),
	.i_con_Walupc8(wb_con_Walupc8),/////////////
	.i_con_Wmemtoreg(wb_con_Wmemtoreg),

	.o_data_regwrite(id_data_Wregwrite)

);

endmodule