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
              (input  [4:0] i_data_rtE,i_data_rdE, 
               input        i_con_regdst, 
               output [4:0] o_data_writeE);

  assign o_data_writeE = i_con_regdst ? i_data_rdE : i_data_rtE; 

endmodule
                     

