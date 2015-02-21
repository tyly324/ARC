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
module EX_pcadd(input [31:0] i_addr_pcadd4E, i_data_immshiftl,
                output[31:0] o_addr_pcbranchE);

  assign o_addr_pcbranchE = i_addr_pcadd4E + i_data_immshiftl;
  
endmodule
