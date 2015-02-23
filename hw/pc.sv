////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: 
// Module: 
// Description: 
//
// Vision: Ver 1.0.0 - File Create
// Comments: 
//
////////////////////////////////////////////////
module pc(
	input i_clk,
	input i_rst_n,
    input [31:0] next_pc,
    output [31:0] pc);

logic [31:0] pc;

always_ff @(posedge i_clk or negedge i_rst_n) 
begin
	if(~i_rst_n) begin
		pc <= 0;
	end 
	else begin
		pc <= next_pc;
	end
end
      
endmodule
             
