`timescale 1ns / 1ps
module D_pcadd(input [31:0] i_addr_pcadd4E, i_data_immshiftl,
                output[31:0] o_addr_pcbranchE);

  assign o_addr_pcbranchE = i_addr_pcadd4E + i_data_immshiftl;
  
endmodule
