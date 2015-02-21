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
	input [31:0] i_addr_AddRst
	input [31:0] i_con_PCSrc,
	input [31:0] i_data_Instr,

	output o_data_Instr,
	output o_addr_NextPC,
	output o_addr_PC
	);

//wire
wire mux0;
wire mux1;
wire pc_in;
wire pc_out;
wire add_out;

//registers in pipeline
logic [31:0] next_PC;
logic [31:0] fetch_instruction;

//outputs
assign o_data_Instr = fetch_instruction;
assign o_addr_NextPC = next_PC;

//store value into pipeline
always_ff @(posedge i_clk) 
begin : store_pipeline
	next_PC <= add_out;
	fetch_instruction <= i_data_Instr;
end

IF_pcmux u_mux( .i_addr_pcadd4(mux0),
		.i_addr_pcbranchM(mux1),
		.i_con_pcsrc(i_con_PCSrc),
		.o_addr_nextpc(pc_in)
);

pc_add u_pc_add(  .i_addr_pc(pc_out), 
		  .o_addr_pcadd4(add_out)
);

endmodule
