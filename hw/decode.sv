//compare
//control
//jbcon
//pcadd
//regbank
//sl
//signext
//jumpext
module decode(
	input logic i_clk,
	input logic i_nrst,
	input logic [31:0] i_addr_pc4,
	input logic [31:0] i_data_instr,
	input logic i_con_Wregwrite,
	input logic [31:0]i_data_Wregwrite,
	input logic [4:0]i_addr_Wregwrite,
	//forward///////////////////////////
	input logic [4:0] i_addr_Erd,
	input logic [4:0] i_addr_Mrd,
	input logic i_con_Eregwrite,
	input logic i_con_Mregwrite,
	input logic [4:0] i_addr_rtM,/////////////
	input logic [4:0] i_addr_rtW,///////////
	input logic i_con_memreadM,///////////
	input logic i_con_memreadW,/////////
	//input logic [31:0] i_data_aluresE,/////////
	//input logic [31:0] i_data_memoutM,/////////

	//register bank
	output logic [31:0] o_data_rs,
	output logic [31:0] o_data_rt,
	output logic [4:0] o_addr_rd,
	output logic [4:0] o_addr_rt,
	output logic [31:0] o_data_jr, //***********
	//output logic [4:0] o_addr_rs,////////////////
	//pc feedback
	//output logic o_con_ifbranch,
	output logic [1:0] o_con_jump,     //////////////////
	output logic [31:0] o_addr_pc4,
	output logic [31:0] o_addr_branch,///////////
	output logic [31:0] o_addr_jump,
	//control signals
	output logic [5:0] o_con_Ealuop,
	output logic o_con_Ealusrc,
	output logic o_con_Eregdst,
	output logic o_con_Mmemread,
	output logic o_con_Mmemwrite,
	output logic [1:0] o_con_Wloadmux,
	output logic o_con_Walupc8,///////////
	output logic o_con_Wmemtoreg,
	output logic o_con_Wregwrite,
	//branch////////////
	output logic o_con_ifstall,
	output logic [2:0] o_con_Ebop,///////////
	//data
	output logic [31:0] o_data_signext,
	//forward unit/////////////////
	output logic [2:0] o_con_Efamux,
	output logic [2:0] o_con_Efbmux,
	output logic [31:0] o_data_Fmemout
	);

// ====================
// I/O
// ====================
// //compare
// wire compare_o_con_ifbranch;
// wire [31:0] compare_i_data_rs;
// wire [31:0] compare_i_data_rt;   
// wire [1:0] compare_i_con_bop; /////////
 
//control
wire control_o_con_regdst;
wire control_o_con_memread;
wire control_o_con_memtoreg;
wire control_o_con_memwrite;
wire control_o_con_alusrc;
wire control_o_con_regwrite;
wire control_o_con_ifsign;
wire [1:0] control_o_con_loadsig;
wire [5:0] control_o_con_aluop; 
wire [5:0] control_i_con_instru;

//jbcon
wire [1:0] jbcon_o_con_jump;
wire [2:0] jbcon_o_con_bop;
wire jbcon_o_con_aluPC4;
wire [5:0] jbcon_i_con_instru;
wire [5:0] jbcon_i_con_func;
wire jbcon_o_con_ifstall;
//wire jbcon_i_con_rt;////////////////

//pcadd
wire [31:0] pcadd_i_addr_pcadd4E, pcadd_i_data_immshiftl;
wire [31:0] pcadd_o_addr_pcbranchE;
 
//regbank
wire [4:0] regbank_i_addr_Rs;
wire [4:0] regbank_i_addr_Rt;
wire regbank_i_con_RegWr;
wire [4:0] regbank_i_addr_Rd;
wire [31:0] regbank_i_data_Rd;
wire [31:0] regbank_o_data_Rs;
wire [31:0] regbank_o_data_Rt;
 
//sl
wire [15:0] sl_i_data_immE;
wire [31:0] sl_o_data_immshiftl;
 
//signext
wire [15:0] signext_i_data_immD;
wire signext_i_con_signext;
wire [31:0] signext_o_data_immD;

//jumpext
wire [25:0] jumpext_i_addr_j;
wire [3:0] jumpext_i_PC4_j;
wire [31:0] jumpext_o_addr_j;

//forward////////////////////////////////
wire [4:0] for_i_addr_rs; 
wire [4:0] for_i_addr_rt;
wire [4:0] for_i_addr_rdM;
wire [4:0] for_i_addr_rdW;
wire for_i_con_regwriteM;
wire for_i_con_regwriteW;
wire [2:0] for_o_con_fa;
wire [2:0] for_o_con_fb;
wire [4:0] for_i_addr_rtM;////////////
wire [4:0] for_i_addr_rtW;//////////
wire for_i_con_memreadM;///////////
wire for_i_con_memreadW;/////////
wire for_o_con_cmpalu;//////////////
wire for_o_con_cmpmem;/////////////
//cmpmux//////////////////////////
wire [31:0] cmpmux_i_data_rs;
wire [31:0] cmpmux_i_data_aluresE;
wire cmpmux_i_con_cmpalu;
wire [31:0] cmpmux_o_data_cmprs;
//cmpmux2/////////////////
wire [31:0] cmpmux2_i_data_rs;
wire [31:0] cmpmux2_i_data_memout;
wire cmpmux2_i_con_cmpmem;
wire [31:0] cmpmux2_o_data_cmprs;

// ====================
// Registers
// ====================
	//registers
logic [31:0] pipe_data_rs;
logic [31:0] pipe_data_rt;
logic [4:0] pipe_addr_rd;
logic [4:0] pipe_addr_rt;
//logic [4:0] pipe_addr_rs;//////////////
logic [31:0] pipe_addr_pc4;
logic [5:0] pipe_con_Ealuop;
logic pipe_con_Ealusrc;
logic pipe_con_Eregdst;
logic pipe_con_EaluPC4;
logic pipe_con_Mmemread;
logic pipe_con_Mmemwrite;
logic [1:0] pipe_con_Wloadmux;
logic pipe_con_Wmemtoreg;
logic pipe_con_Wregwrite;
logic [31:0]pipe_signext_o_data_immD;
//forward//////////////////////
logic [2:0] pipe_con_Efamux;
logic [2:0] pipe_con_Efbmux;
logic [31:0] pipe_memout;
//branch
logic [31:0] pipe_addr_branch;
logic [2:0] pipe_bop;

always_ff @(posedge i_clk, negedge i_nrst)
begin
	if(~i_nrst) begin
		pipe_data_rs <= 0;
		pipe_data_rt <= 0;
		pipe_addr_rd <= 0;
		pipe_addr_rt <= 0;
		//pipe_addr_rs <= 0;///////////////
		pipe_addr_pc4 <= 0;
		pipe_con_Ealuop <= 0;
		pipe_con_Ealusrc <= 0;
		pipe_con_Eregdst <= 0;
		pipe_con_EaluPC4 <= 0;
		pipe_con_Mmemread <= 0;
		pipe_con_Mmemwrite <= 0;
		pipe_con_Wloadmux <= 0;
		pipe_con_Wmemtoreg <= 0;
		pipe_con_Wregwrite <= 0;
		pipe_signext_o_data_immD <= 0;
		//forward///////////////////
		pipe_con_Efamux <= 0;
		pipe_con_Efbmux <= 0;
		pipe_memout <= 0;
		//branch
		pipe_addr_branch <= 0;
		pipe_bop <= 0;
	end 
	else begin
		pipe_data_rs <= regbank_o_data_Rs;
		pipe_data_rt <= regbank_o_data_Rt;
		pipe_addr_rd <= i_data_instr[15:11];
		pipe_addr_rt <= i_data_instr[20:16];
		//pipe_addr_rs <= i_data_instr[25:21];/////////////////
		pipe_addr_pc4 <= i_addr_pc4;
		pipe_con_Ealuop <= control_o_con_aluop; 
		pipe_con_Ealusrc <= control_o_con_alusrc;
		pipe_con_Eregdst <= control_o_con_regdst;
		pipe_con_EaluPC4 <= jbcon_o_con_aluPC4;
		pipe_con_Mmemread <= control_o_con_memread;
		pipe_con_Mmemwrite <= control_o_con_memwrite;
		pipe_con_Wloadmux <= control_o_con_loadsig;
		pipe_con_Wmemtoreg <= control_o_con_memtoreg;
		pipe_con_Wregwrite <= control_o_con_regwrite;
		pipe_signext_o_data_immD <= signext_o_data_immD;
		//forward/////////////////////
		pipe_con_Efamux <= for_o_con_fa;
		pipe_con_Efbmux <= for_o_con_fb;
		pipe_memout <= i_data_Wregwrite;
		//branch
		pipe_addr_branch <= pcadd_o_addr_pcbranchE;
		pipe_bop <= jbcon_o_con_bop;
	end
end

// ====================
// Interconnection
// ====================
// //compare
// assign compare_i_data_rs = cmpmux2_o_data_cmprs;
// assign compare_i_data_rt = regbank_o_data_Rt;   
// assign compare_i_con_bop = jbcon_o_con_bop;
//control
assign control_i_con_instru = i_data_instr[31:26];
//jbcon
assign jbcon_i_con_instru = i_data_instr[31:26];
assign jbcon_i_con_func = i_data_instr[5:0];
//assign jbcon_i_con_rt = i_data_instr[16];//////////////
//pcadd
assign pcadd_i_addr_pcadd4E = i_addr_pc4;
assign pcadd_i_data_immshiftl = sl_o_data_immshiftl;
//regbank
assign regbank_i_addr_Rs = i_data_instr[25:21];
assign regbank_i_addr_Rt = i_data_instr[20:16];
assign regbank_i_con_RegWr = i_con_Wregwrite;
assign regbank_i_addr_Rd = i_addr_Wregwrite;
assign regbank_i_data_Rd = i_data_Wregwrite;
//sl
assign sl_i_data_immE = i_data_instr[15:0];
//signext
assign signext_i_data_immD = i_data_instr[15:0];
assign signext_i_con_signext = control_o_con_ifsign;
//jumpext
assign jumpext_i_addr_j = i_data_instr[25:0];
assign jumpext_i_PC4_j = i_addr_pc4[31:28];

//forward/////////////////////////////////////////
assign for_i_addr_rs = i_data_instr[25:21];
assign for_i_addr_rt = i_data_instr[20:16];
assign for_i_addr_rdM = i_addr_Erd;
assign for_i_addr_rdW = i_addr_Mrd;
assign for_i_con_regwriteM = i_con_Eregwrite;
assign for_i_con_regwriteW = i_con_Mregwrite;
assign for_i_addr_rtM = i_addr_rtM;/////////////
assign for_i_addr_rtW = i_addr_rtW;///////////
assign for_i_con_memreadM = i_con_memreadM;///////////
assign for_i_con_memreadW = i_con_memreadW;/////////
// //cmpmux/////////////////////
// assign cmpmux_i_data_rs = regbank_o_data_Rs;
// assign cmpmux_i_data_aluresE = i_data_aluresE;
// assign cmpmux_i_con_cmpalu = for_o_con_cmpalu;
// //cmpmux2/////////////////
// assign cmpmux2_i_data_rs = cmpmux_o_data_cmprs;
// assign cmpmux2_i_data_memout = i_data_memoutM;
// assign cmpmux2_i_con_cmpmem = for_o_con_cmpmem;


//outputs
//register bank
assign o_data_rs = pipe_data_rs;
assign o_data_rt = pipe_data_rt;
assign o_addr_rd = pipe_addr_rd;
assign o_addr_rt = pipe_addr_rt;
assign o_data_jr = regbank_o_data_Rs;
//assign o_addr_rs = pipe_addr_rs;/////////////////
//pc feedback
//assign o_con_ifbranch = compare_o_con_ifbranch;
assign o_con_jump = jbcon_o_con_jump;
assign o_addr_pc4 = pipe_addr_pc4;
assign o_addr_branch = pipe_addr_branch;/////////
assign o_addr_jump = jumpext_o_addr_j;
//control signals
assign o_con_Ealuop = pipe_con_Ealuop; 
assign o_con_Ealusrc = pipe_con_Ealusrc;
assign o_con_Eregdst = pipe_con_Eregdst;
assign o_con_Walupc8 = pipe_con_EaluPC4;
assign o_con_Mmemread = pipe_con_Mmemread;
assign o_con_Mmemwrite = pipe_con_Mmemwrite;
assign o_con_Wloadmux = pipe_con_Wloadmux;
assign o_con_Wmemtoreg = pipe_con_Wmemtoreg;
assign o_con_Wregwrite = pipe_con_Wregwrite;
//branch////////////
assign o_con_ifstall = jbcon_o_con_ifstall;
assign o_con_Ebop = pipe_bop;///////////
//data
assign o_data_signext = pipe_signext_o_data_immD;
//forward unit///////////////////////////////
assign o_con_Efamux = pipe_con_Efamux;
assign o_con_Efbmux = pipe_con_Efbmux;
assign o_data_Fmemout = pipe_memout;



// ====================
// Hirearchy
// ====================
//compare
// D_compare u_compare(
// .o_con_ifbranch(compare_o_con_ifbranch),
// .i_data_rs(compare_i_data_rs),     // 25:21 
// .i_data_rt(compare_i_data_rt),     // 20:16     
// .i_con_bop(compare_i_con_bop)     // come from branch_jump 
// );

//control
D_control u_control(
.o_con_regdst(control_o_con_regdst), 
.o_con_memread(control_o_con_memread), 
.o_con_memtoreg(control_o_con_memtoreg),  
.o_con_memwrite(control_o_con_memwrite), 
.o_con_alusrc(control_o_con_alusrc), 
.o_con_regwrite(control_o_con_regwrite), 
.o_con_ifsign(control_o_con_ifsign),
.o_con_loadsig(control_o_con_loadsig),
.o_con_aluop(control_o_con_aluop), 
.i_con_instru(control_i_con_instru)
);

//jbcon
D_jb_control u_jb_control(
.o_con_ifstall(jbcon_o_con_ifstall),
.o_con_jump(jbcon_o_con_jump),
.o_con_bop(jbcon_o_con_bop),
.o_con_aluPC4(jbcon_o_con_aluPC4),
.i_con_instru(jbcon_i_con_instru),        // opcode
.i_con_func(jbcon_i_con_func)          // function code
//.i_con_rt(jbcon_i_con_rt)////////////////
);           // 16th of the instruction

//pcadd
D_pcadd u_pcadd(
.i_addr_pcadd4E(pcadd_i_addr_pcadd4E), 
.i_data_immshiftl(pcadd_i_data_immshiftl),
.o_addr_pcbranchE(pcadd_o_addr_pcbranchE)
);

//regbank
D_register_bank u_regbank(
.i_clk(i_clk),
.i_rst_n(i_nrst),
.i_addr_Rs(regbank_i_addr_Rs),
.i_addr_Rt(regbank_i_addr_Rt),
.i_con_RegWr(regbank_i_con_RegWr),
.i_addr_Rd(regbank_i_addr_Rd),
.i_data_Rd(regbank_i_data_Rd),
.o_data_Rs(regbank_o_data_Rs),
.o_data_Rt(regbank_o_data_Rt)
);

//sl
D_shiftleft u_sl(
.i_data_immE(sl_i_data_immE),
.o_data_immshiftl(sl_o_data_immshiftl)
);

//signext
D_sign_extend u_signext(
.i_data_immD(signext_i_data_immD),
.i_con_signext(signext_i_con_signext),
.o_data_immD(signext_o_data_immD)
);

//jumpext
D_jump_ext u_jump_ext(
.i_addr_j(jumpext_i_addr_j),
.i_PC4_j(jumpext_i_PC4_j),
.o_addr_j(jumpext_o_addr_j)
);

//forward///////////////////////////////
E_forward u_forward(
.i_addr_rs(for_i_addr_rs), 
.i_addr_rt(for_i_addr_rt), 
.i_addr_rdM(for_i_addr_rdM), 
.i_addr_rdW(for_i_addr_rdW), 
.i_addr_rtM(for_i_addr_rtM),
.i_addr_rtW(for_i_addr_rtW),
.i_con_regwriteM(for_i_con_regwriteM), 
.i_con_regwriteW(for_i_con_regwriteW),
.i_con_memreadM(for_i_con_memreadM),
.i_con_memreadW(for_i_con_memreadW),
.o_con_fa(for_o_con_fa), 
.o_con_fb(for_o_con_fb)
//.o_con_cmpalu(for_o_con_cmpalu),
//.o_con_cmpmem(for_o_con_cmpmem)
);

// //cmpmux////////////////////
// D_cmpmux u_cmpmux(
// .i_data_rs(cmpmux_i_data_rs),
// .i_data_aluresE(cmpmux_i_data_aluresE),
// .i_con_cmpalu(cmpmux_i_con_cmpalu),
// .o_data_cmprs(cmpmux_o_data_cmprs)
// );
// //cmpmux2/////////////////
// D_cmpmux2 u_cmpmux2(
// .i_data_rs(cmpmux2_i_data_rs),
// .i_data_memout(cmpmux2_i_data_memout),
// .i_con_cmpmem(cmpmux2_i_con_cmpmem),
// .o_data_cmprs(cmpmux2_o_data_cmprs)
// );

endmodule