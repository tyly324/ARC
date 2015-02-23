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
module shiftleft2 (input  [29:0] i_data_immE,
                   output [31:0] o_data_immshiftl);

  assign  o_data_immshiftl = {i_data_immE,2'b0};
endmodule
