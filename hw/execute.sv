//alu
//alucontrol
//aluamux
//alubmux
//famux5
//fbmux5
//forward
//rdmux
module execute(
	input logic i_clk,
	input logic i_nrst,
	input logic [31:0] i_data_pc4,
	input logic [31:0] i_data_rs,
	input logic [31:0] i_data_rt,
	input logic [31:0] i_data_immext,
	//input logic [4:0] i_addr_rs,/////////////////
	input logic [4:0] i_addr_rt,
	input logic [4:0] i_addr_rd,
	//forward
	input logic [31:0] i_data_FEalures,
	input logic [31:0] i_data_FMalures,
	input logic [31:0] i_data_FMmemout,////////////
	input logic [31:0] i_data_FWmemout,////////////
	//control
	input logic [5:0] i_con_Ealuop,
	input logic i_con_Ealusrc,
	input logic i_con_Eregdst,
	input logic i_con_Mmemread,
	input logic i_con_Mmemwrite,
	input logic [1:0] i_con_Wloadmux,
	input logic i_con_Walupc8,///////////
	input logic i_con_Wmemtoreg,
	input logic i_con_Wregwrite,
	//forward unit///////////////////
	input logic [2:0] i_con_Efamux,
	input logic [2:0] i_con_Efbmux,
	//branch
	input logic [2:0] i_con_bop,

	output logic [31:0] o_data_pc4,///////////
	output logic [31:0] o_data_alures,
	output logic [31:0] o_data_rt,
	output logic [4:0] o_addr_regdst,
	output logic o_con_Mmemread,
	output logic o_con_Mmemwrite,
	output logic [1:0] o_con_Wloadmux,
	output logic o_con_Walupc8,///////////
	output logic o_con_Wmemtoreg,
	output logic o_con_Wregwrite,
	//forward feedback//////////////////////
	output logic [4:0] o_addr_Erd,
	output logic [4:0] o_addr_Mrt,
	//output logic [31:0] o_FaluresE,
	//branch
	output logic o_con_ifbranch
	);

// ====================
// I/O
// ====================
//compare
wire compare_o_con_ifbranch;
wire [31:0] compare_i_data_rs;
wire [31:0] compare_i_data_rt;   
wire [2:0] compare_i_con_bop; /////////
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
//famux5 
wire [31:0] famux5_i_data_rs; 
wire [31:0] famux5_i_data_alures; 
wire [31:0] famux5_i_data_writeres;
wire [31:0] famux5_i_data_lwM;
wire [31:0] famux5_i_data_lwW;
wire [2:0]  famux5_i_con_fa;
wire [31:0] famux5_o_data_alusra;
//fbmux5
wire [31:0] fbmux5_i_data_rt;
wire [31:0] fbmux5_i_data_alures;
wire [31:0] fbmux5_i_data_writeres;
//wire [31:0] fbmux5_i_data_imm;
wire [31:0] fbmux5_i_data_lwM;
wire [31:0] fbmux5_i_data_lwW;
wire [2:0]  fbmux5_i_con_fb;
wire [31:0] fbmux5_o_data_alusrb;
//alubmux
wire [31:0] alubmux_i_data_fb;
wire [31:0] alubmux_i_data_imm;
wire alubmux_i_con_imm;
wire [31:0] alubmux_o_data_alub;
//rdmux
wire [4:0] rdmux_i_data_rtE, rdmux_i_data_rdE;
wire rdmux_i_con_regdst;
wire [4:0] rdmux_o_data_writeE;
wire rdmux_i_con_jal;


// ====================
// Registers
// ====================

//data & address
logic [31:0] pipe_alures;
logic [31:0] pipe_rt;
logic [4:0] pipe_regdst;
logic [31:0] pipe_pc4;///////////
//control
logic pipe_con_Mmemread;
logic pipe_con_Mmemwrite;
logic [1:0] pipe_con_Wloadmux;
logic pipe_con_Walupc8;///////////
logic pipe_con_Wmemtoreg;
logic pipe_con_Wregwrite;
//forward 
logic [4:0] pipe_addr_rt;

always_ff @(posedge i_clk, negedge i_nrst)
begin
	if(~i_nrst) begin
		pipe_pc4 <= 0;//////////////
		pipe_alures <= 0;
		pipe_rt <= 0;
		pipe_regdst <= 0;
		pipe_con_Mmemread <= 0;
		pipe_con_Mmemwrite <= 0;
		pipe_con_Wloadmux <= 0;
		pipe_con_Walupc8 <= 0;/////////////
		pipe_con_Wmemtoreg <= 0;
		pipe_con_Wregwrite <= 0;
		pipe_addr_rt <= 0;
	end
	else begin
		pipe_pc4 <= i_data_pc4;//////////
		pipe_alures <= alu_o_data_AluRes;
		pipe_rt <= fbmux5_o_data_alusrb;
		pipe_regdst <= rdmux_o_data_writeE;
		pipe_con_Mmemread <= i_con_Mmemread;
		pipe_con_Mmemwrite <= i_con_Mmemwrite;
		pipe_con_Wloadmux <= i_con_Wloadmux;
		pipe_con_Walupc8 <= i_con_Walupc8;//////////
		pipe_con_Wmemtoreg <= i_con_Wmemtoreg;
		pipe_con_Wregwrite <= i_con_Wregwrite;
		pipe_addr_rt <= i_addr_rt;
	end
end
// ====================
// Interconnection
// ====================
// ===inputs
//compare
assign compare_i_data_rs = famux5_o_data_alusra;
assign compare_i_data_rt = fbmux5_o_data_alusrb;   
assign compare_i_con_bop = i_con_bop;
//alu
assign alu_i_data_A = famux5_o_data_alusra;
assign alu_i_data_B = alubmux_o_data_alub;
assign alu_i_data_shamt = i_data_immext[10:6];
assign alu_i_con_AluCtrl = aluc_o_con_AluCtrl;
//alucontrol
assign aluc_i_con_AluOp = i_con_Ealuop;
assign aluc_i_con_FuncCode = i_data_immext[5:0];
//famux5
assign famux5_i_data_rs = i_data_rs;
assign famux5_i_data_alures = i_data_FEalures;
assign famux5_i_data_writeres = i_data_FMalures;
assign famux5_i_data_lwM = i_data_FMmemout;//////////////
assign famux5_i_data_lwW = i_data_FWmemout;//////////////
assign famux5_i_con_fa = i_con_Efamux;
//fbmux5
assign fbmux5_i_data_rt = i_data_rt;
assign fbmux5_i_data_alures = i_data_FEalures;
assign fbmux5_i_data_writeres = i_data_FMalures;
assign fbmux5_i_data_lwM = i_data_FMmemout;//////////////
assign fbmux5_i_data_lwW = i_data_FWmemout;//////////////
assign fbmux5_i_con_fb = i_con_Efbmux;
//alubmux
assign alubmux_i_data_fb = fbmux5_o_data_alusrb;
assign alubmux_i_data_imm = i_data_immext;
assign alubmux_i_con_imm = i_con_Ealusrc;
//rdmux
assign rdmux_i_data_rdE = i_addr_rd;
assign rdmux_i_data_rtE = i_addr_rt;
assign rdmux_i_con_regdst = i_con_Eregdst;
assign rdmux_i_con_jal = i_con_Walupc8;//********

// ==outputs
assign o_data_pc4 = pipe_pc4;///////////
assign o_data_alures = pipe_alures;
assign o_data_rt = pipe_rt;
assign o_addr_regdst = pipe_regdst;
assign o_con_Mmemread = pipe_con_Mmemread;
assign o_con_Mmemwrite = pipe_con_Mmemwrite;
assign o_con_Wloadmux = pipe_con_Wloadmux;
assign o_con_Walupc8 = pipe_con_Walupc8;
assign o_con_Wmemtoreg = pipe_con_Wmemtoreg;
assign o_con_Wregwrite = pipe_con_Wregwrite;
//forward feedback////////////////////////////
assign o_addr_Erd = rdmux_o_data_writeE;
assign o_addr_Mrt = pipe_addr_rt;
//assign o_FaluresE = alu_o_data_AluRes;
//branch///////////////
assign o_con_ifbranch = compare_o_con_ifbranch;


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

//famux5
E_famux5 u_famux5(
.i_data_rs(famux5_i_data_rs), 
.i_data_alures(famux5_i_data_alures), 
.i_data_writeres(famux5_i_data_writeres),
.i_data_lwM(famux5_i_data_lwM),
.i_data_lwW(famux5_i_data_lwW),
.i_con_fa(famux5_i_con_fa), 
.o_data_alusra(famux5_o_data_alusra)
);
//fbmux5
E_fbmux5 u_fbmux(
.i_data_rt(fbmux5_i_data_rt),
.i_data_alures(fbmux5_i_data_alures),
.i_data_writeres(fbmux5_i_data_writeres),
.i_data_lwM(fbmux5_i_data_lwM),
.i_data_lwW(fbmux5_i_data_lwW),
.i_con_fb(fbmux5_i_con_fb), 
.o_data_alusrb(fbmux5_o_data_alusrb)
);

//alubmux
E_alubmux u_alubmux(
.i_data_fb(alubmux_i_data_fb), 
.i_data_imm(alubmux_i_data_imm),
.i_con_imm(alubmux_i_con_imm),
.o_data_alub(alubmux_o_data_alub)
);

//rdmux
E_rdmux u_rdmux(
.i_data_rtE(rdmux_i_data_rtE),
.i_data_rdE(rdmux_i_data_rdE), 
.i_con_regdst(rdmux_i_con_regdst), 
.i_con_aluPC4(rdmux_i_con_jal),//******
.o_data_writeE(rdmux_o_data_writeE)
);

D_compare u_compare(
.o_con_ifbranch(compare_o_con_ifbranch),
.i_data_rs(compare_i_data_rs),     // 25:21 
.i_data_rt(compare_i_data_rt),     // 20:16     
.i_con_bop(compare_i_con_bop)     // come from branch_jump 
);
endmodule