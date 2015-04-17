`timescale 1ns / 1ps
module E_fbmux4(
  input logic [31:0] i_data_rt, 
  input logic [31:0] i_data_alures, 
  input logic [31:0] i_data_writeres, 
  input logic [31:0] i_data_imm,
  input logic [1:0] i_con_fb, 
  output logic [31:0] o_data_alusrb);

always_comb
case(i_con_fb)
  2'b00 : o_data_alusrb = i_data_rt;
  2'b01 : o_data_alusrb = i_data_writeres;
  2'b10 : o_data_alusrb = i_data_alures;
  2'b11 : o_data_alusrb = i_data_imm;
endcase

endmodule
             
