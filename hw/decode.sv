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
	input i_con_RegWr,
	input [31:0] i_addr_NextPC,
	input [31:0] i_data_Instr,
	input [31:0] i_addr_WrReg,
	input [31:0] i_data_WrData

	output o_con_
	);
// ====================
// wire
// ====================
// control
wire control_input;
// registers
wire [4:0] rs_address;
wire [4:0] rt_address;
wire [31:0] rs_value;
wire [31:0] rt_value;
wire [4:0] rd_address;
wire [31:0] rd_value;
wire register_write;
// sign_extend
wire [15:0] sign_ext_in;
wire [31:0] sign_ext_out;

// ====================
// registers
// ====================
// control
logic cache_control_ex_regdst;
logic cache_control_mem_branch;
logic cache_control_mem_memread;
logic cache_control_wb_memtoreg;
logic cache_control_mem_memwrite;
logic cache_control_ex_alusrc;
logic cache_control_wb_regwrite; 
logic [1:0] cache_control_ex_aluop;
// registers
logic [31:0] cache_registers_rs;
logic [31:0] cache_registers_rt;
//sign-extend
logic [31:0] cache_sign_ext;
//rd address
logic [4:0] cache_rd_mux_0;
logic [4:0] cache_rd_mux_1;


// ====================
// Interconnection
// ====================
assign control_input = i_data_Instr[31:26];

assign rs_address = i_data_Instr[25:21];
assign rt_address = i_data_Instr[20:16];
assign rd_address = i_addr_WrReg;
assign rd_value = i_data_WrData;

assign sign_ext_in = i_data_Instr[15:0];





control u_control (	.o_con_regdst(cache_control_ex_regdst), 
					.o_con_branch(cache_control_mem_branch), 
					.o_con_memread(cache_control_mem_memread), 
					.o_con_memtoreg(cache_control_wb_memtoreg), 
					.o_con_memwrite(cache_control_mem_memwrite), 
					.o_con_alusrc(cache_control_ex_alusrc), 
					.o_con_regwrite(cache_control_wb_regwrite), 
        			.[1:0] o_con_aluop(cache_control_ex_aluop), 
					.[5:0] i_con_instru(control_input)
);

register_bank u_register_bank(	.i_clk(i_clk),
								.i_addr_Rs(rs_address), 
								.i_addr_Rt(rt_address),
								.i_con_RegWr(register_write),
								.i_addr_Rd(rd_address),
								.i_data_Rd(rd_value),
								.o_data_Rs(rs_value),
								.o_data_Rt(rt_value)
);