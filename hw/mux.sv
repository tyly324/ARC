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
module mux2 #(parameter WIDTH = 32)
              (input  [WIDTH-1:0] d0, d1, 
               input              s, 
               output [WIDTH-1:0] y);

  assign y = s ? d1 : d0; 

endmodule
/*
mux2 #(32) IF_pcmux (.d0 (i_addr_pcadd4),
                     .d1 (i_addr_pcbranchM), 
                     .s  (i_con_pcsrc), 
                     .y  (o_addr_nextpc));
                     
                     
                     
mux2 #(32) EX_alumux (.d0 (i_data_writeE),
                      .d1 (i_data_immE), 
                     .s  (i_con_alusrc), 
                     .y  (o_data_scrb));
                     
                     
mux2 #(5)  EX_writemux (.d0 (instruction[20:16]),
                       .d1  (instruction[15:11]), 
                       .s  (i_con_regdst), 
                       .y  (o_data_writeE));                 
                     
                     
mux2 #(32)  WB_resmux (.d0 (i_data_aluresW),
                       .d1 (i_data_readW), 
                       .s  (i_con_memtoreg), 
                       .y  (o_data_result));   
*/