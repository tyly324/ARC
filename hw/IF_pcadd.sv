`timescale 1ns / 1ps
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
module IF_pcadd(input [31:0]i_addr_pc, 
              output [31:0] o_addr_pcadd4);
      
    assign o_addr_pcadd4 =i_addr_pc + 32'b100;
    
endmodule
    
