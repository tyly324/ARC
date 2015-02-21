////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: Zhiyuan Jiang
// Module: execute
// Description: The third stage in pipleline, 
// 				execute the instruction.
//
// Vision: Ver 1.0.1 - First version
// Comments: 
//
////////////////////////////////////////////////
module execute(
	//control
	input i_con_ex_regdst,
	input i_con_mem_branch,
	input i_con_mem_memread,
	input i_con_wb_memtoreg,
	input i_con_mem_memwrite,
	input i_con_ex_alusrc,
	input i_con_wb_regwrite,
	input [1:0] i_con_ex_aluop,
	//Next PC
	input [31:0] i_addr_NextPC,
	// registers
	input [31:0] i_data_rs,
	input [31:0] i_data_rt,
	//sign-extend
	input [31:0] i_data_SignExt,
	//rd address
	input [4:0] i_addr_mux_0,
	input [4:0] i_addr_mux_1,

	output o_con_mem_branch,
	output o_con_mem_memread,
	output o_con_wb_memtoreg,
	output o_con_mem_memwrite,
	output o_con_wb_regwrite,

	output [31:0] o_data_AddRst,
	output o_con_Zero,
	output [31:0] o_data_ALU_Rst,
	output [31:0] o_data_rt,
	output [4:0] o_addr_MuxRst

	);

// ====================
// wire
// ====================
//Add
wire [31:0] add_in_up;
wire [31:0] add_in_down;
wire [31:0] add_out;
//shifter
wire [31:0] shifter_in;
wire [31:0] shifter_out;
//ALU
wire [31:0] alu_in_up;
wire [31:0] alu_in_down;
wire [3:0] alu_in_control;
wire alu_out_zero;
wire [31:0] alu_out_result;
//alumux
wire [31:0] alumux_in_0;
wire [31:0] alumux_in_1;
wire alumux_select;
wire [31:0] alumux_out;
//alu control
wire [5:0] alucontrol_function;
wire [1:0] alucontrol_op;
wire [3:0] alucontrol_out;
//mux
wire [4:0] mux_in_0;
wire [4:0] mux_in_1;
wire mux_select;
wire [4:0] mux_out;

// ====================
// registers
// ====================
logic cache_control_mem_branch;
logic cache_control_mem_memread;
logic cache_control_wb_memtoreg;
logic cache_control_mem_memwrite;
logic cache_control_wb_regwrite;
//Add
logic [31:0] cache_add_result;
//ALU
logic cache_zero;
logic [31:0] cache_alu_result;
//rt
logic [31:0] cache_rt;
//mux
logic [4:0] cache_mux_result; 

// ====================
// interconnection
// ====================
//Input
//add
assign add_in_up = i_addr_NextPC;
assign add_in_down = shifter_out;
//shifter
assign shifter_in = i_data_SignExt;
//alu
assign alu_in_up = i_data_rs;
assign alu_in_down = alumux_out;
assign alu_in_control = alucontrol_out;
//alumux
assign alumux_in_0 = i_data_rt;
assign alumux_in_1 = i_data_SignExt;
assign alumux_select = i_con_ex_alusrc;
//alucontrol
assign alucontrol_function = i_data_SignExt[5:0];
assign alucontrol_op = i_con_ex_aluop;
//mux
assign mux_in_0 = i_addr_mux_0;
assign mux_in_1 = i_addr_mux_1;
assign mux_select = i_con_ex_regdst;

//Output
assign o_con_mem_branch = cache_control_mem_branch;
assign o_con_mem_memread = cache_control_mem_memread;
assign o_con_wb_memtoreg = cache_control_wb_memtoreg;
assign o_con_mem_memwrite = cache_control_mem_memwrite;
assign o_con_wb_regwrite = cache_control_wb_regwrite;

assign o_data_AddRst = cache_add_result;
assign o_con_Zero = cache_zero;
assign o_data_ALU_Rst = cache_alu_result;
assign o_data_rt = cache_rt;
assign o_addr_MuxRst = cache_mux_result;

// ====================
// Store data in cache
// ====================
always_ff @(posedge i_clk)
begin
	//control
	cache_control_mem_branch <= i_con_mem_branch;
	cache_control_mem_memread <= i_con_mem_memread;
	cache_control_wb_memtoreg <= i_con_wb_memtoreg;
	cache_control_mem_memwrite <= i_con_mem_memwrite;
	cache_control_wb_regwrite <= i_con_wb_regwrite;
	//add 
	cache_add_result <= add_out;
	//ALU
	cache_zero <= alu_out_zero;
	cache_alu_result <= alu_out_result;
	//rt
	cache_rt <= i_data_rt;
	//mux result
	cache_mux_result <= mux_out;
end

// ====================
// Hirearchy
// ====================
EX_pcadd u_expcadd(	.i_addr_pcadd4E(add_in_up), 
					.i_data_immshiftl(add_in_down),
                	.o_addr_pcbranchE(add_out)
);

shiftleft2 u_shiftleft2(	.i_data_immE(shifter_in),
                   			.o_data_immshiftl(shifter_out)
);

alu u_alu(	.o_data_AluRes(alu_out_result), 
			.o_con_Zero(alu_out_zero), 
			.i_data_A(alu_in_up), 
			.i_data_B(alu_in_down), 
			.i_con_AluCtrl(alu_in_control)
);

EX_alumux u_ex_alumux(	.i_data_writeE(alumux_in_0),
						.i_data_immE(alumux_in_1), 
               			.i_con_alusrc(alumux_select), 
               			.o_data_scrb(alumux_out)
);

alu_control u_alu_control(	.o_con_AluCtrl(alucontrol_out), 
							.i_con_AluOp(alucontrol_op), 
							.i_con_FuncCode(alucontrol_function)
);

EX_writemux u_ex_writemux(	.i_data_rtE(mux_in_0),
							.i_data_rdE(mux_in_1), 
               				.i_con_regdst(mux_select), 
               				.o_data_writeE(mux_out)
);

endmodule