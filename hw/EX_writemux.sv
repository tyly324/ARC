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
module EX_writemux
              (input  [4:0] instruction[20:16], instruction[15:11], 
               input        i_con_regdst, 
               output [4:0] o_data_writeE);

  assign o_data_writeE = i_con_regdst ? instruction[15:11] : instruction[20:16]; 

endmodule
                     

