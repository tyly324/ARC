`timescale 1ns / 1ps
module E_fbmux3
              (input  logic[31:0] i_data_rt, i_data_alures, i_data_writeres,
               input  logic[1:0]  i_con_fb, 
               output logic[31:0] o_data_alusrb);

  always_comb
  begin
    o_data_alusrb=0;
    case(i_con_fb)
      2'b00: o_data_alusrb=i_data_rt;
      2'b10: o_data_alusrb=i_data_alures;
      2'b01: o_data_alusrb=i_data_writeres;
    endcase
  end 

endmodule
             
