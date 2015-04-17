//pcmux
//pc
//add4
module fetch(
	input logic i_clk,
	input logic i_nrst,
	input logic [31:0]i_addr_b,
	input logic [31:0]i_addr_j,
	input logic [31:0]i_addr_jr,
	input logic i_con_b,
	input logic [1:0] i_con_j,  //////////
	input logic [31:0]i_data_instr,

	output logic [31:0] o_addr_pc,
	output logic [31:0] o_addr_pc4,
	output logic [31:0] o_data_instr
	);

// ====================
// I/O
// ====================
//pcmux
wire [31:0] pcmux_i_addr_jump;
wire [31:0] pcmux_i_addr_jumpr;
wire [31:0] pcmux_i_addr_pc;
wire [31:0] pcmux_i_addr_branch;
wire [1:0]  pcmux_i_con_jump;
wire pcmux_i_con_ifbranch;
wire [31:0] pcmux_o_addr_nextpc;
//pc
wire [31:0] pc_i_addr_next_pc;
wire [31:0] pc_o_addr_pc;
//add4
wire [31:0] add4_i_addr_pc;
wire [31:0] add4_o_addr_pcadd4;

// ====================
// Registers
// ====================
logic [31:0] pipe_pc;
logic [31:0] pipe_pc4;
logic [31:0] pipe_instr;

always_ff @(posedge i_clk, negedge i_nrst)
if(~i_nrst) begin
	pipe_pc <= 0;
	pipe_pc4 <= 0;
	pipe_instr <= 0;
end
else begin 
	pipe_pc <= pc_o_addr_pc;
	pipe_pc4 <= add4_o_addr_pcadd4;
	pipe_instr <= i_data_instr;
end

// ====================
// Interconnection
// ====================
//pcmux
assign pcmux_i_addr_jump = i_addr_j;
assign pcmux_i_addr_jumpr = i_addr_jr;
assign pcmux_i_addr_pc = add4_o_addr_pcadd4;
assign pcmux_i_addr_branch = i_addr_b;
assign pcmux_i_con_jump = i_con_j;
assign pcmux_i_con_ifbranch = i_con_b;
//pc
assign pc_i_addr_next_pc = pcmux_o_addr_nextpc;
//add4
assign add4_i_addr_pc = pc_o_addr_pc;

//outputs
assign o_addr_pc = pipe_pc;
assign o_addr_pc4 = pipe_pc4;
assign o_data_instr = pipe_instr;


// ====================
// Hirearchy
// ====================
//pcmux
F_pcmux u_pcmux(
.i_addr_jump(pcmux_i_addr_jump),
.i_addr_jumpr(pcmux_i_addr_jumpr),
.i_addr_pc(pcmux_i_addr_pc),
.i_addr_branch(pcmux_i_addr_branch),
.i_con_jump(pcmux_i_con_jump),
.i_con_ifbranch(pcmux_i_con_ifbranch),
.o_addr_nextpc(pcmux_o_addr_nextpc)
);

//pc
F_pc u_pc(
.i_clk(i_clk),
.i_rst_n(i_nrst),
.i_addr_next_pc(pc_i_addr_next_pc),
.o_addr_pc(pc_o_addr_pc)
);

//add4
F_add4 u_add4(
.i_addr_pc(add4_i_addr_pc), 
.o_addr_pcadd4(add4_o_addr_pcadd4)
);

endmodule
