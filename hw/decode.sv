////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: Zhiyuan Jiang
// Module: decode
// Description: The second stage in pipleline, 
// 				decode the instruction and read
//				data from registers bank.
//
// Vision: Ver 1.0.3 - Add reset signal
// Comments: 
//
////////////////////////////////////////////////
module decode(
	input i_clk,
	input i_rst_n,

	input i_con_RegWr,
	input [31:0] i_addr_NextPC,
	input [31:0] i_data_Instr,
	input [4:0] i_addr_WrReg,
	input [31:0] i_data_WrData,

	//control
	output o_con_ex_regdst,
	output o_con_mem_branch,
	output o_con_mem_memread,
	output o_con_wb_memtoreg,
	output o_con_mem_memwrite,
	output o_con_ex_alusrc,
	output o_con_wb_regwrite,
	output [1:0] o_con_ex_aluop,
	//Next PC
	output [31:0] o_addr_NextPC,
	// registers
	output [31:0] o_data_rs,
	output [31:0] o_data_rt,
	//sign-extend
	output [31:0] o_data_SignExt,
	//rd address
	output [4:0] o_addr_mux_0,
	output [4:0] o_addr_mux_1
	);


// ====================
// wire
// ====================
// control
wire [5:0] control_input;
wire control_ex_regdst;
wire control_mem_branch;
wire control_mem_memread;
wire control_wb_memtoreg;
wire control_mem_memwrite;
wire control_ex_alusrc;
wire control_wb_regwrite; 
wire [1:0] control_ex_aluop;
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
//Next PC
logic [31:0] cache_NextPC;
// registers
logic [31:0] cache_registers_rs;
logic [31:0] cache_registers_rt;
//sign-extend
logic [31:0] cache_sign_ext;
//rd address
logic [4:0] cache_mux_0;
logic [4:0] cache_mux_1;


// ====================
// Interconnection
// ====================
//input
assign control_input = i_data_Instr[31:26];

assign rs_address = i_data_Instr[25:21];
assign rt_address = i_data_Instr[20:16];
assign rd_address = i_addr_WrReg;
assign rd_value = i_data_WrData;
assign register_write = i_con_RegWr;

assign sign_ext_in = i_data_Instr[15:0];

//Output
//control 
assign o_con_ex_regdst = cache_control_ex_regdst;
assign o_con_mem_branch = cache_control_mem_branch;
assign o_con_mem_memread = cache_control_mem_memread;
assign o_con_wb_memtoreg = cache_control_wb_memtoreg;
assign o_con_mem_memwrite = cache_control_mem_memwrite;
assign o_con_ex_alusrc = cache_control_ex_alusrc;
assign o_con_wb_regwrite = cache_control_wb_regwrite;  
assign o_con_ex_aluop = cache_control_ex_aluop;
//Next PC 
assign o_addr_NextPC = cache_NextPC;
// registers 
assign o_data_rs = cache_registers_rs;
assign o_data_rt = cache_registers_rt;
//sign-extend 
assign o_data_SignExt = cache_sign_ext;
//rd address 
assign o_addr_mux_0 = cache_mux_0;
assign o_addr_mux_1 = cache_mux_1;


// ====================
// Store data in cache
// ====================
always_ff @(posedge i_clk or negedge i_rst_n) 
begin
	if(~i_rst_n) begin
		//control
		cache_control_ex_regdst <= 0;
		cache_control_mem_branch <= 0;
		cache_control_mem_memread <= 0;
		cache_control_wb_memtoreg <= 0;
		cache_control_mem_memwrite <= 0;
		cache_control_ex_alusrc <= 0;
		cache_control_wb_regwrite <= 0; 
		cache_control_ex_aluop <= 0;
		//NextPC
		cache_NextPC <= 0;
		//registers
		cache_registers_rs <= 0;
		cache_registers_rt <= 0;
		//sign ext
		cache_sign_ext <= 0;
		//mux address
		cache_mux_0 <= '0;
		cache_mux_1 <= '0;
	end 
	else begin
		//control
		cache_control_ex_regdst <= control_ex_regdst;
		cache_control_mem_branch <= control_mem_branch;
		cache_control_mem_memread <= control_mem_memread;
		cache_control_wb_memtoreg <= control_wb_memtoreg;
		cache_control_mem_memwrite <= control_mem_memwrite;
		cache_control_ex_alusrc <= control_ex_alusrc;
		cache_control_wb_regwrite <= control_wb_regwrite; 
		cache_control_ex_aluop <= control_ex_aluop;
		//NextPC
		cache_NextPC <= i_addr_NextPC;
		//registers
		cache_registers_rs <= rs_value;
		cache_registers_rt <= rt_value;
		//sign ext
		cache_sign_ext <= sign_ext_out;
		//mux address
		cache_mux_0 <= i_data_Instr[20:16];
		cache_mux_1 <= i_data_Instr[15:11];
	end
end


// ====================
// hirearchy
// ====================
sign_extend u_sign_ext(	.i_data_immD(sign_ext_in),
                   		.o_data_immD(sign_ext_out)
);

control u_control (	.o_con_regdst(control_ex_regdst), 
					.o_con_branch(control_mem_branch), 
					.o_con_memread(control_mem_memread), 
					.o_con_memtoreg(control_wb_memtoreg), 
					.o_con_memwrite(control_mem_memwrite), 
					.o_con_alusrc(control_ex_alusrc), 
					.o_con_regwrite(control_wb_regwrite), 
        			.o_con_aluop(control_ex_aluop), 
					.i_con_instru(control_input)
);

register_bank u_register_bank(	.i_clk(i_clk),
								.i_rst_n(i_rst_n),
								.i_addr_Rs(rs_address), 
								.i_addr_Rt(rt_address),
								.i_con_RegWr(register_write),
								.i_addr_Rd(rd_address),
								.i_data_Rd(rd_value),
								.o_data_Rs(rs_value),
								.o_data_Rt(rt_value)
);

endmodule