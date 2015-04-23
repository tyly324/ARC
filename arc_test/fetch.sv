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
	//branch/////////////
	input logic i_con_ifstall,

	output logic [31:0] o_addr_pc,
	output logic [31:0] o_addr_pc4,
	output logic [31:0] o_data_instr
	);

// ====================
// I/O
// ====================
//jumpmux
wire [31:0] jmux_i_addr_j;
wire [31:0] jmux_i_addr_jr;
wire [31:0] jmux_i_addr_pc4;
wire [1:0] jmux_i_con_jump;
wire [31:0] jmux_o_addr_jumpmux;
//branchmux
wire [31:0] bmux_i_addr_jumpmux;
wire [31:0] bmux_i_addr_b;
wire bmux_i_con_ifbranch;
wire [31:0] bmux_o_addr_nextpc;
//pc
wire pc_i_con_stall;
wire [31:0] pc_i_addr_next_pc;
wire [31:0] pc_o_addr_pc;
//add4
wire [31:0] add4_i_addr_pc;
wire [31:0] add4_o_addr_pcadd4;

// ====================
// Registers
// ====================
logic [31:0] pipe_pc4;
logic [31:0] pipe_instr;

always_ff @(posedge i_clk, negedge i_nrst)
if(~i_nrst) begin
	pipe_pc4 <= 0;
	pipe_instr <= 0;
end
else begin 
	pipe_pc4 <= add4_o_addr_pcadd4;
	pipe_instr <= i_data_instr;
end

// ====================
// Interconnection
// ====================
//jumpmux
assign jmux_i_addr_j = i_addr_j;
assign jmux_i_addr_jr = i_addr_jr;
assign jmux_i_addr_pc4 = add4_o_addr_pcadd4;
assign jmux_i_con_jump = i_con_j;
//branchmux
assign bmux_i_addr_jumpmux = jmux_o_addr_jumpmux;
assign bmux_i_addr_b = i_addr_b;
assign bmux_i_con_ifbranch = i_con_b;
//pc
assign pc_i_con_stall = i_con_ifstall;
assign pc_i_addr_next_pc = bmux_o_addr_nextpc;
//add4
assign add4_i_addr_pc = pc_o_addr_pc;

//outputs
assign o_addr_pc = pc_o_addr_pc;
assign o_addr_pc4 = pipe_pc4;
assign o_data_instr = pipe_instr;


// ====================
// Hirearchy
// ====================
//jumpmux
F_jumpmux u_jumpmux(
.i_addr_j(jmux_i_addr_j),
.i_addr_jr(jmux_i_addr_jr),
.i_addr_pc4(jmux_i_addr_pc4),
.i_con_jump(jmux_i_con_jump),
.o_addr_jumpmux(jmux_o_addr_jumpmux)
);

//branchmux
F_branchmux u_branchmux(
.i_addr_jumpmux(bmux_i_addr_jumpmux),
.i_addr_b(bmux_i_addr_b),
.i_con_ifbranch(bmux_i_con_ifbranch),
.o_addr_nextpc(bmux_o_addr_nextpc)
);


//pc
F_pc u_pc(
.i_clk(i_clk),
.i_rst_n(i_nrst),
.i_con_stall(pc_i_con_stall),
.i_addr_next_pc(pc_i_addr_next_pc),
.o_addr_pc(pc_o_addr_pc)
);

//add4
F_add4 u_add4(
.i_addr_pc(add4_i_addr_pc), 
.o_addr_pcadd4(add4_o_addr_pcadd4)
);

endmodule
