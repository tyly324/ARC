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
module EX_alumux 
              (input  [31:0] i_data_writeE, i_data_immE, 
               input         i_con_alusrc, 
               output [31:0] o_data_scrb);

  assign o_data_scrb = i_con_alusrc ? i_data_immE : i_data_writeE; 

endmodule

                     
                     
                     

