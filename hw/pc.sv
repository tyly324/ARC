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
module pc_ff(input clock,
             input [31:0] next_pc,
             output[31:0] pc);

always_ff(posedge clock)
      pc <= next_pc;
      
endmodule
             
