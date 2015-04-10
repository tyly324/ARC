//compare
//control
//jbcon
//pcadd
//regbank
//sl
//signext
//unsignext
module decode(
	input logic i_clk,
	input logic i_nrst,
	input logic [31:0] i_addr_pc4,
	input logic [31:0] i_data_instr,
	input logic i_con_Wregwrite,
	input logic i_data_Wregwrite,
	input logic i_addr_Wregwrite,

	//registers
	output logic [31:0] o_data_rs,
	output logic [31:0] o_data_rt,
	output logic [4:0] o_addr_rd,
	output logic [4:0] o_addr_rt,
	output logic [4:0] o_addr_rs,
	//pc
	output logic o_con_ifbranch,
	output logic o_con_jump,
	output logic [31:0] o_addr_pc4,
	output logic [31:0] o_addr_pcadd,
	output logic [31:0] o_addr_jump,
	//control
	output logic [5:0] o_con_Ealuop,
	output logic o_con_Ealusrc,
	output logic o_con_Eregdst,
	output logic o_con_Mmemread,
	output logic o_con_Mmemwrite,
	output logic o_con_Wmemtoreg,
	output logic o_con_Wregwrite
	);

// ====================
// I/O
// ====================
//compare
wire compare_o_con_ifbranch;
wire [31:0] compare_i_data_rs;
wire [31:0] compare_i_data_rt;   
wire [2:0] compare_i_con_bop;
 
//control
wire control_o_con_regdst;
wire control_o_con_memread;
wire control_o_con_memtoreg;
wire control_o_con_memwrite;
wire control_o_con_alusrc;
wire control_o_con_regwrite;
wire control_o_con_ifsign;
wire [5:0] control_o_con_aluop; 
wire [5:0] control_i_con_instru;

//jbcon
wire [1:0] jbcon_o_con_jump;
wire [2:0] jbcon_o_con_bop;
wire [5:0] jbcon_i_con_instru;
wire [5:0] jbcon_i_con_func;
wire jbcon_i_con_rt;

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
wire signext_i_clk;
wire [31:0] signext_o_data_immD;

//unsignext
wire [25:0] unsignext_i_addr_j;
wire [31:0] unsignext_o_addr_j;

// ====================
// Interconnection
// ====================
//compare
assign compare_i_data_rs = regbank_o_data_Rs;
assign compare_i_data_rt = regbank_o_data_Rt;   
assign compare_i_con_bop = jbcon_o_con_bop;
//control
assign control_i_con_instru = i_data_instr[31:26];
//jbcon
assign jbcon_i_con_instru = i_data_instr[31:26];
assign jbcon_i_con_func = i_data_instr[5:0];
assign jbcon_i_con_rt = i_data_instr[16];
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
//unsignext
assign unsignext_i_addr_j = i_data_instr[25:0];

//outputs
//registers
assign o_data_rs = pipe_data_rs;
assign o_data_rt = pipe_data_rt;
assign o_addr_rd = pipe_addr_rd;
assign o_addr_rt = pipe_addr_rt;
assign o_addr_rs = pipe_addr_rs;
//pc
assign o_con_ifbranch = compare_o_con_ifbranch;
assign o_con_jump = jbcon_o_con_jump;
assign o_addr_pc4 = pipe_addr_pc4;
assign o_addr_pcadd = pcadd_o_addr_pcbranchE;
assign o_addr_jump = unsignext_o_addr_j;
//control
assign o_con_Ealuop = pipe_con_aluop; 
assign o_con_Ealusrc = pipe_con_alusrc;
assign o_con_Eregdst = pipe_con_regdst;
assign o_con_Mmemread = pipe_con_memread;
assign o_con_Mmemwrite = pipe_con_memwrite;
assign o_con_Wmemtoreg = pipe_con_memtoreg;
assign o_con_Wregwrite = pipe_con_regwrite;

// ====================
// Registers
// ====================
	//registers
logic [31:0] pipe_data_rs;
logic [31:0] pipe_data_rt;
logic [4:0] pipe_addr_rd;
logic [4:0] pipe_addr_rt;
logic [4:0] pipe_addr_rs;
logic [31:0] pipe_addr_pc4;
logic [5:0] pipe_con_Ealuop;
logic pipe_con_Ealusrc;
logic pipe_con_Eregdst;
logic pipe_con_Mmemread;
logic pipe_con_Mmemwrite;
logic pipe_con_Wmemtoreg;
logic pipe_con_Wregwrite;

always_ff @(posedge i_clk, negedge i_nrst)
begin
	if(~i_nrst) begin
		pipe_data_rs <= 0;
		pipe_data_rt <= 0;
		pipe_addr_rd <= 0;
		pipe_addr_rt <= 0;
		pipe_addr_rs <= 0;
		pipe_addr_pc4 <= 0;
		pipe_con_Ealuop <= 0;
		pipe_con_Ealusrc <= 0;
		pipe_con_Eregdst <= 0;
		pipe_con_Mmemread <= 0;
		pipe_con_Mmemwrite <= 0;
		pipe_con_Wmemtoreg <= 0;
		pipe_con_Wregwrite <= 0;
	end 
	else begin
		pipe_data_rs <= regbank_o_data_Rs;
		pipe_data_rt <= regbank_o_data_Rt;
		pipe_addr_rd <= i_data_instr[15:11];
		pipe_addr_rt <= i_data_instr[20:16];
		pipe_addr_rs <= i_data_instr[25:21];
		pipe_addr_pc4 <= i_addr_pc4;
		pipe_con_aluop = control_o_con_aluop; 
		pipe_con_alusrc = control_o_con_alusrc;
		pipe_con_regdst = control_o_con_regdst;
		pipe_con_memread = control_o_con_memread;
		pipe_con_memwrite = control_o_con_memwrite;
		pipe_con_memtoreg = control_o_con_memtoreg;
		pipe_con_regwrite = control_o_con_regwrite;
	end
end
// ====================
// Hirearchy
// ====================
//compare
D_compare u_compare(
.o_con_ifbranch(compare_o_con_ifbranch),
.i_data_rs(compare_i_data_rs),     // 25:21 
.i_data_rt(compare_i_data_rt),     // 20:16     
.i_con_bop(compare_i_con_bop)     // come from branch_jump 
);

//control
D_control u_control(
.o_con_regdst(control_o_con_regdst), 
.o_con_memread(control_o_con_memread), 
.o_con_memtoreg(control_o_con_memtoreg),  
.o_con_memwrite(control_o_con_memwrite), 
.o_con_alusrc(control_o_con_alusrc), 
.o_con_regwrite(control_o_con_regwrite), 
.o_con_ifsign(control_o_con_ifsign),
.o_con_aluop(control_o_con_aluop), 
.i_con_instru(control_i_con_instru)
);

//jbcon
D_jb_control u_jb_control(
.o_con_jump(jbcon_o_con_jump),
.o_con_bop(jbcon_o_con_bop),
.i_con_instru(jbcon_i_con_instru),        // opcode
.i_con_func(jbcon_i_con_func),          // function code
.i_con_rt(jbcon_i_con_rt)
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

//unsignext
D_unsign_extend u_unsignext(
.i_addr_j(unsignext_i_addr_j_),
.o_addr_j(unsignext_o_addr_j)
);

endmodule