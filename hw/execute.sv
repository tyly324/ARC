//alu
//alucontrol
//aluamux
//alubmux
//famux3
//fbmux3
//forward
//rdmux
module execute(
	input logic i_clk,
	input logic i_nrst,
	input logic [31:0] i_data_pc4,
	input logic [31:0] i_data_rs,
	input logic [31:0] i_data_rt,
	input logic [31:0] i_data_immext,
	input logic [4:0] i_addr_rs,
	input logic [4:0] i_addr_rt,
	input logic [4:0] i_addr_rd,
	//forward
	input logic [31:0] i_data_FEalures,
	input logic [31:0] i_data_FMalures,
	input logic [4:0] i_addr_FMregdst,
	input logic [4:0] i_addr_FWregdst,
	input logic i_con_FMregwrite,
	input logic i_con_FWregwrite,
	//control
	input logic [5:0] i_con_Ealuop,
	input logic i_con_Ealusrc,
	input logic i_con_Eregdst,
	input logic i_con_Ealupc4,
	input logic i_con_Mmemread,
	input logic i_con_Mmemwrite,
	input logic [1:0] i_con_Wloadmux,
	input logic i_con_Wmemtoreg,
	input logic i_con_Wregwrite,

	output logic [31:0] o_data_alures,
	output logic [31:0] o_data_rt,
	output logic [4:0] o_addr_regdst,
	output logic o_con_Mmemread,
	output logic o_con_Mmemwrite,
	output logic [1:0] o_con_Wloadmux,
	output logic o_con_Wmemtoreg,
	output logic o_con_Wregwrite
	);

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
wire [31:0] aluamux_i_data_fa;
wire [31:0] aluamux_i_data_pc4;
wire aluamux_i_con_jump;
wire [31:0] aluamux_o_data_alua;
//alubmux
wire [31:0] alubmux_i_data_fb;
wire [31:0] alubmux_i_data_imm;
wire alubmux_i_con_imm;
wire [31:0] alubmux_o_data_alub;
//famux3 
wire [31:0] famux3_i_data_rs, famux3_i_data_alures, famux3_i_data_writeres;
wire [1:0]  famux3_i_con_fa;
wire [31:0] famux3_o_data_alusra;
//fbmux3
wire [31:0] fbmux3_i_data_rt, fbmux3_i_data_alures, fbmux3_i_data_writeres;
wire [1:0]  fbmux3_i_con_fb;
wire [31:0] fbmux3_o_data_alusrb;
//forward
wire [4:0] for_i_data_rs, for_i_data_rt, for_i_data_rdM, for_i_data_rdW;
wire for_i_con_regwriteM, for_i_con_regwriteW;
wire [1:0] for_o_con_fa, for_o_con_fb;
//rdmux
wire [4:0] rdmux_i_data_rtE, rdmux_i_data_rdE;
wire rdmux_i_con_regdst;
wire [4:0] rdmux_o_data_writeE;


// ====================
// Registers
// ====================

//data & address
logic [31:0] pipe_alures;
logic [31:0] pipe_rt;
logic [4:0] pipe_regdst;
//control
logic pipe_con_Mmemread;
logic pipe_con_Mmemwrite;
logic [1:0] pipe_con_Wloadmux;
logic pipe_con_Wmemtoreg;
logic pipe_con_Wregwrite;

always_ff @(posedge i_clk, negedge i_nrst)
begin
	if(~i_nrst) begin
		pipe_alures <= 0;
		pipe_rt <= 0;
		pipe_regdst <= 0;
		pipe_con_Mmemread <= 0;
		pipe_con_Mmemwrite <= 0;
		pipe_con_Wloadmux <= 0;
		pipe_con_Wmemtoreg <= 0;
		pipe_con_Wregwrite <= 0;
	end
	else begin
		pipe_alures <= alu_o_data_AluRes;
		pipe_rt <= fbmux3_o_data_alusrb;
		pipe_regdst <= rdmux_o_data_writeE;
		pipe_con_Mmemread <= i_con_Mmemread;
		pipe_con_Mmemwrite <= i_con_Mmemwrite;
		pipe_con_Wloadmux <= i_con_Wloadmux;
		pipe_con_Wmemtoreg <= i_con_Wmemtoreg;
		pipe_con_Wregwrite <= i_con_Wregwrite;
	end
end
// ====================
// Interconnection
// ====================
// ===inputs
//alu
assign alu_i_data_A = aluamux_o_data_alua;
assign alu_i_data_B = alubmux_o_data_alub;
assign alu_i_data_shamt = i_data_immext[10:6];
assign alu_i_con_AluCtrl = aluc_o_con_AluCtrl;
//alucontrol
assign aluc_i_con_AluOp = i_con_Ealuop;
assign aluc_i_con_FuncCode = i_data_immext[5:0];
//aluamux
assign aluamux_i_data_fa = famux3_o_data_alusra;
assign aluamux_i_data_pc4 = i_data_pc4;
assign aluamux_i_con_jump = i_con_Ealupc4;
//alubmux
assign alubmux_i_data_fb = fbmux3_o_data_alusrb;
assign alubmux_i_data_imm = i_data_immext;
assign alubmux_i_con_imm = i_con_Ealusrc;
//famux3
assign famux3_i_data_rs = i_data_rs;
assign famux3_i_data_alures = i_data_FEalures;
assign famux3_i_data_writeres = i_data_FMalures;
assign famux3_i_con_fa = for_o_con_fa;
//fbmux3
assign fbmux3_i_data_rt = i_data_rt;
assign fbmux3_i_data_alures = i_data_FEalures;
assign fbmux3_i_data_writeres = i_data_FMalures;
assign fbmux3_i_con_fb = for_o_con_fb;
//forward
assign for_i_data_rs = i_addr_rs;
assign for_i_data_rt = i_addr_rt;
assign for_i_data_rdM = i_addr_FMregdst;
assign for_i_data_rdW = i_addr_FWregdst;
assign for_i_con_regwriteM = i_con_FMregwrite;
assign for_i_con_regwriteW = i_con_FWregwrite;
//rdmux
assign rdmux_i_data_rdE = i_addr_rd;
assign rdmux_i_data_rtE = i_addr_rt;
assign rdmux_i_con_regdst = i_con_Eregdst;
assign rdmux_i_con_jal = i_con_Ealupc4;//********

// ==outputs
assign o_data_alures = pipe_alures;
assign o_data_rt = pipe_rt;
assign o_addr_regdst = pipe_regdst;
assign o_con_Mmemread = pipe_con_Mmemread;
assign o_con_Mmemwrite = pipe_con_Mmemwrite;
assign o_con_Wloadmux = pipe_con_Wloadmux;
assign o_con_Wmemtoreg = pipe_con_Wmemtoreg;
assign o_con_Wregwrite = pipe_con_Wregwrite;


// ====================
// Hirearchy
// ====================

//alu

E_alu u_alu(
.o_data_AluRes(alu_o_data_AluRes), 
.i_data_A(alu_i_data_A), 
.i_data_B(alu_i_data_B), 
.i_con_AluCtrl(alu_i_con_AluCtrl), 
.i_data_shamt(alu_i_data_shamt)
);

//alucontrol
E_alu_control u_alu_control(
.o_con_AluCtrl(aluc_o_con_AluCtrl),
.i_con_AluOp(aluc_i_con_AluOp), 
.i_con_FuncCode(aluc_i_con_FuncCode)
);

//aluamux
E_aluamux u_aluamux(
.i_data_fa(aluamux_i_data_fa), 
.i_data_pc4(aluamux_i_data_pc4),
.i_con_jump(aluamux_i_con_jump),
.o_data_alua(aluamux_o_data_alua)
);

//alubmux
E_alubmux u_alubmux(
.i_data_fb(alubmux_i_data_fb), 
.i_data_imm(alubmux_i_data_imm),
.i_con_imm(alubmux_i_con_imm),
.o_data_alub(alubmux_o_data_alub)
);

//famux3
E_famux3 u_famux3(
.i_data_rs(famux3_i_data_rs), 
.i_data_alures(famux3_i_data_alures), 
.i_data_writeres(famux3_i_data_writeres),
.i_con_fa(famux3_i_con_fa), 
.o_data_alusra(famux3_o_data_alusra)
);

//fbmux3
E_fbmux3 u_fbmux3(
.i_data_rt(fbmux3_i_data_rt), 
.i_data_alures(fbmux3_i_data_alures), 
.i_data_writeres(fbmux3_i_data_writeres), 
.i_con_fb(fbmux3_i_con_fb), 
.o_data_alusrb(fbmux3_o_data_alusrb)
);

//forward
E_forward u_forward(
.i_data_rs(for_i_data_rs), 
.i_data_rt(for_i_data_rt), 
.i_data_rdM(for_i_data_rdM), 
.i_data_rdW(for_i_data_rdW), 
.i_con_regwriteM(for_i_con_regwriteM), 
.i_con_regwriteW(for_i_con_regwriteW), 
.o_con_fa(for_o_con_fa), 
.o_con_fb(for_o_con_fb)
);

//rdmux
E_rdmux u_rdmux(
.i_data_rtE(rdmux_i_data_rtE),
.i_data_rdE(rdmux_i_data_rdE), 
.i_con_regdst(rdmux_i_con_regdst), 
.i_con_aluPC4(rdmux_i_con_jal),//******
.o_data_writeE(rdmux_o_data_writeE)
);

endmodule