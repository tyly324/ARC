////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: Zhiyuan Jiang
// Module: mem
// Description: The forth stage in pipleline, 
// 				access an operand in data memory.
//
// Vision: Ver 1.0.1 - First version
// Comments: 
//
////////////////////////////////////////////////
module mem(
	input i_clk,
	input i_con_mem_branch,
	input i_con_wb_memtoreg,
	input i_con_wb_regwrite,
	input i_con_Zero,
	input [31:0] i_data_ALU_Rst,
	input [4:0] i_addr_MuxRst,
	input [31:0] i_data_Memory, //input data from data memory
	input [31:0] i_addr_AddRst, //input from expcadd, hy7g14 14 pm 03/03 
	input i_con_mem_JumpReg, //input from control, hy7g14 14 pm 03/03

	output o_con_wb_memtoreg,
	output o_con_wb_regwrite,
	output o_con_PCSrc,
	output [31:0] o_data_Memory,
	output [31:0] o_data_ALU_Rst,
	output [4:0] o_addr_MuxRst,
	output [31:0] o_addr_JBpc // jump or branch pc source, hy7g14 14 pm 03/03
);


// ====================
// wire
// ====================
//jrmux
wire [31:0] jrmux_in_branch;
wire [31:0] jrmux_in_rs;
wire jrmux_in_select;
wire [31:0] jrmux_out_JBpc;


// ====================
// registers
// ====================
//control
logic cache_control_wb_memtoreg;
logic cache_control_wb_regwrite;
//data memory
logic [31:0] cache_data_mem;
//alu result
logic [31:0] cache_alu_result;
//mux
logic [4:0] cache_mux_result;

// ====================
// interconnection
// ====================
//Input
assign jrmux_in_branch = i_addr_AddRst;
assign jrmux_in_rs = i_data_ALU_Rst;
assign jrmux_in_select = i_con_mem_JumpReg;

//Output
assign o_con_wb_memtoreg = cache_control_wb_memtoreg;
assign o_con_wb_regwrite = cache_control_wb_regwrite;
assign o_con_PCSrc = (i_con_mem_branch & i_con_Zero)|i_con_JumpReg; //hy7g14 14 pm 03/03
assign o_data_Memory = cache_data_mem;
assign o_data_ALU_Rst = cache_alu_result;
assign o_addr_MuxRst = cache_mux_result;
assign o_addr_JBpc = jrmux_out_JBpc;

// ====================
// Store data in cache
// ====================
always_ff @(posedge i_clk) 
begin
	//control
	cache_control_wb_memtoreg <= i_con_wb_memtoreg;
	cache_control_wb_regwrite <= i_con_wb_regwrite;
	//data memory
	cache_data_mem <= i_data_Memory;
	//alu result
	cache_alu_result <= i_data_ALU_Rst;
	//mux
	cache_mux_result <= i_addr_MuxRst;
end

// ====================
// Hirearchy
// ====================
MEM_jrmux u_mem_jrmux(	.i_addr_branch(jrmux_in_branch),
						.i_data_rs(jrmux_in_rs),
						.i_con_jumpr(jrmux_in_select),
						.o_addr_JBpc(jrmux_out_JBpc)
	) //jump reg selector, hy7g14 14 pm 03/03


endmodule