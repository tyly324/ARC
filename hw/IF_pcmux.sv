`timescale 1ns / 1ps
module IF_pcmux 
              (input  [31:0] i_addr_pcadd4, i_addr_pcbranchM, 
               input         i_con_pcsrc, 
               output [31:0] o_addr_nextpc);

  assign o_addr_nextpc = i_con_pcsrc ? i_addr_pcbranchM : i_addr_pcadd4; 

endmodule        


