`timescale 1ns / 1ps
////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: Zhiyuan Jiang
// Module: mem
// Description: The forth stage in pipleline, 
// 				access an operand in data memory.
//
// Vision: Ver 1.0.2 - Add reset signal
// Comments: 
//
////////////////////////////////////////////////
module mem(
	input i_clk,
	input i_rst_n,

	input i_con_mem_branch,
	input i_con_wb_memtoreg,
	input i_con_wb_regwrite,
	input i_con_Zero,
	input [31:0] i_data_ALU_Rst,
	input [4:0] i_addr_MuxRst,
	input [31:0] i_data_Memory, //input data from data memory

	output o_con_wb_memtoreg,
	output o_con_wb_regwrite,
	output o_con_PCSrc,
	output [31:0] o_data_Memory,
	output [31:0] o_data_ALU_Rst,
	output [4:0] o_addr_MuxRst
);


// ====================
// wire
// ====================
//none


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


//Output
assign o_con_wb_memtoreg = cache_control_wb_memtoreg;
assign o_con_wb_regwrite = cache_control_wb_regwrite;
assign o_con_PCSrc = i_con_mem_branch & i_con_Zero;
assign o_data_Memory = cache_data_mem;
assign o_data_ALU_Rst = cache_alu_result;
assign o_addr_MuxRst = cache_mux_result;

// ====================
// Store data in cache
// ====================
always_ff @(posedge i_clk or negedge i_rst_n) begin : proc_
	if(~i_rst_n) begin
		//control
		cache_control_wb_memtoreg <= 0;
		cache_control_wb_regwrite <= 0;
		//data memory
		cache_data_mem <= 0;
		//alu result
		cache_alu_result <= 0;
		//mux
		cache_mux_result <= 0;
	end 
	else begin
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
end

// ====================
// Hirearchy
// ====================
//none


endmodule