`timescale 1ns / 1ps
module E_rdmux
              (input  [4:0] i_data_rtE,i_data_rdE, 
               input        i_con_regdst, i_con_aluPC4,//******
               output [4:0] o_data_writeE);

  assign o_data_writeE = i_con_aluPC4 ? 5'b11111:
  						 i_con_regdst ? i_data_rdE : i_data_rtE; 

endmodule
                     

