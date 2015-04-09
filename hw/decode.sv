//alu
//alucontrol
//aluamux
//alubmux
//famux3
//fbmux3
//forward
//rdmux
module decode();

// ====================
// I/O
// ====================
//alu
wire [31:0] alu_o_data_AluRes; 
wire [31:0] alu_i_data_A;
wire [31:0] alu_i_data_B;
wire [3:0] alu_i_con_AluCtrl;
wire [4:0] alu_i_data_shamt;
//alucontrol
wire [3:0] aluc_o_con_AluCtrl;
wire [5:0] aluc_i_con_AluOp;
wire [5:0] aluc_i_con_FuncCode;
//aluamux
//alubmux
//famux3 
wire [31:0] famux3_i_data_rs, famux3_i_data_alures, famux3_i_data_writeres;
wire [1:0]  famux3_i_con_fa;
wire [31:0] famux3_o_data_alusra;
//fbmux3
wire [31:0] fbmux3_i_data_rt, fbmux3_i_data_alures, fbmux3_i_data_writeres;
wire [1:0]  fbmux3_i_con_fb;
wire [31:0] fbmux3_o_data_alusrb);
//forward
wire [4:0] for_i_data_rs, for_i_data_rt, for_i_data_rdM, for_i_data_rdW;
wire for_i_con_regwriteM, for_i_con_regwriteW;
wire [1:0] for_o_con_fa, for_o_con_fb;
//rdmux
wire [4:0] rdmux_i_data_rtE, rdmux_i_data_rdE;
wire rdmux_i_con_regdst;
wire [4:0] rdmux_o_data_writeE;

// ====================
// Interconnection
// ====================
//input

//internal

//output


// ====================
// Registers
// ====================


// ====================
// Hirearchy
// ====================

//alu

E_alu(
	output [31:0] o_data_AluRes, 
	input [31:0]i_data_A, 
	input [31:0]i_data_B, 
	input [3:0]i_con_AluCtrl, 
	input [4:0] i_data_shamt);

//alucontrol
E_alu_control(
	output [3:0] o_con_AluCtrl, 
	input [5:0] i_con_AluOp, 
	input [5:0] i_con_FuncCode);

//aluamux
//alubmux
//famux3
E_famux3 
(input  logic[31:0] i_data_rs, i_data_alures, i_data_writeres,
 input  logic[1:0]  i_con_fa, 
 output logic[31:0] o_data_alusra);

//fbmux3
E_fbmux3
(input  logic[31:0] i_data_rt, i_data_alures, i_data_writeres,
 input  logic[1:0]  i_con_fb, 
 output logic[31:0] o_data_alusrb);

//forward
E_forward(
	input  logic[4:0] i_data_rs, i_data_rt, i_data_rdM, i_data_rdW,
	input  logic i_con_regwriteM, i_con_regwriteW,
	output logic [1:0] o_con_fa, o_con_fb);

//rdmux
E_rdmux(
	input  [4:0] i_data_rtE,i_data_rdE, 
	input i_con_regdst, 
	output [4:0] o_data_writeE);

