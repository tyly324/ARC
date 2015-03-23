`timescale 1ns / 1ps
module F_pc(
	input i_clk,
	input i_rst_n,
	input [31:0] i_addr_next_pc,
	output [31:0] o_addr_pc
);

logic [31:0] program_counter;

assign o_addr_pc = program_counter;

always_ff @(posedge i_clk or negedge i_rst_n) 
begin
	if(~i_rst_n) begin
		program_counter <= 0;
	end 
	else begin
		program_counter <= i_addr_next_pc;
	end
end
      
endmodule
             
