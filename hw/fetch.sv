////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: Zhiyuan Jiang
// Module: fetch
// Description: The first stage in pipleline, 
// 				fetch the instruction from memory.
//
// Vision: Ver 1.0.1 - Add content
// Comments: 
//
////////////////////////////////////////////////
module fetch(
	input i_clk,
	input [31:0] i_addr_PC,
	input [31:0] i_data_Instr,

	output o_data_Instr,
	output o_addr_PC
	);

//registers in pipeline
logic [31:0] incremental_PC;
logic [31:0] fetch_instruction;

//outputs
assign o_data_Instr = fetch_instruction;
assign o_addr_PC = incremental_PC;

//store value into pipeline
always_ff @(posedge clk) 
begin : store_pipeline
	incremental_PC <= i_addr_PC;
	fetch_instruction <= i_data_Instr;
end

endmodule