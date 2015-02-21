////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: Zhiyuan Jiang
// Module: fetch
// Description: The first stage in pipleline, 
// 				fetch the instruction from memory.
//
// Vision: Ver 1.0.2 - Correct error
// Comments: 
//
////////////////////////////////////////////////
module fetch(
	input i_clk,
	input [31:0] i_addr_AddRst,
	input [31:0] i_con_PCSrc,
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

//outputs
assign o_data_Instr = fetch_instruction;
assign o_addr_NextPC = next_PC;
assign o_addr_PC = pc_out;

//store value into pipeline
always_ff @(posedge i_clk) 
begin : store_pipeline
	next_PC <= add_out;
	fetch_instruction <= i_data_Instr;
end

IF_pcmux u_mux( 
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
		.clock(i_clk),
        .next_pc(pc_in),
        .pc(pc_out)
);

endmodule
