////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: Zhiyuan Jiang
// Module: fetch
// Description: The first stage in pipleline, 
// 				fetch the instruction from memory.
//
// Vision: Ver 1.0.3 - Add reset signal
// Comments: 
//
////////////////////////////////////////////////
module fetch(
	input i_clk,
	input i_rst_n,
	input [31:0] i_addr_AddRst,
	input i_con_PCSrc,
	input [31:0] i_data_Instr,

	output [31:0] o_data_Instr,
	output [31:0] o_addr_NextPC,
	output [31:0] o_addr_PC
	);

//wire
wire [31:0] mux0;
wire [31:0] mux1;
wire [31:0] pc_in;
wire [31:0] pc_out;
wire [31:0] add_out;

//registers in pipeline
logic [31:0] next_PC;
logic [31:0] fetch_instruction;

// ====================
// Interconnection
// ====================
// inputs
assign mux0 = add_out;
assign mux1 = i_addr_AddRst;

//outputs
assign o_data_Instr = fetch_instruction;
assign o_addr_NextPC = next_PC;
assign o_addr_PC = pc_out;

//store value into pipeline
always_ff @(posedge i_clk or negedge i_rst_n)
begin : store_pipeline
	if(~i_rst_n) begin
		next_PC <= 0;
		fetch_instruction <= 0;
	end 
	else begin
		next_PC <= add_out;
		fetch_instruction <= i_data_Instr;
	end
end

// ====================
// Hirearchy
// ====================
IF_pcmux u_pcmux( 
		.i_addr_pcadd4(mux0),
		.i_addr_pcbranchM(mux1),
		.i_con_pcsrc(i_con_PCSrc),
		.o_addr_nextpc(pc_in)
);

IF_pcadd u_pc_add(  
		.i_addr_pc(pc_out), 
		.o_addr_pcadd4(add_out)
);

pc u_pc(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
        .i_addr_next_pc(pc_in),
        .o_addr_pc(pc_out)
);

endmodule
