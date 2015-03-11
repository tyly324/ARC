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
module three_muxa 
              (input  logic[31:0] i_data_rs, i_data_alures, i_data_writeres,
               input  logic[1:0]  i_con_fa, 
               output logic[31:0] o_data_alusra);

  always_comb
  begin
    o_data_alusra=0;
    case(i_con_fa)
      2'b00: o_data_alusra=i_data_rs;
      2'b10: o_data_alusra=i_data_alures;
      2'b01: o_data_alusra=i_data_writeres;
    endcase
  end 

endmodule
             
