`timescale 1ns / 1ps
module F_pc(
	input logic i_clk,
	input logic i_rst_n,
	input logic i_con_stall,
	input logic i_con_mulpause,
	input logic [31:0] i_addr_next_pc,
	output logic [31:0] o_addr_pc
);

logic [31:0] program_counter;

assign o_addr_pc = program_counter;

always_ff @(posedge i_clk or negedge i_rst_n) 
begin
	if(~i_rst_n) begin
		program_counter <= 0;
	end 
	else if (i_con_stall&&~i_con_mulpause) begin
		program_counter <= i_addr_next_pc;
	end
	else 
		program_counter <= program_counter;
end
      
endmodule
             
