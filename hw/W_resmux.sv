`timescale 1ns / 1ps
module W_resmux 
              (input  [31:0] i_data_aluresW, i_data_readW, 
               input         i_con_memtoreg, 
               output [31:0] o_data_result);

  assign o_data_result = i_con_memtoreg ? i_data_readW : i_data_aluresW; 

endmodule

               
                                       
