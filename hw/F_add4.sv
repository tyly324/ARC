`timescale 1ns / 1ps
module F_add4(input [31:0]i_addr_pc, 
              output [31:0] o_addr_pcadd4);
      
    assign o_addr_pcadd4 =i_addr_pc + 4;
    
endmodule
    
