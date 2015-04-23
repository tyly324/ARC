`timescale 1ns / 1ps
module W_loadmux3
              (input  logic[31:0] i_data_Rdata,
               input  logic[1:0]  i_con_loadsig, 
               output logic[31:0] o_data_Wdata);

  always_comb
  begin
    o_data_Wdata=0;
    case(i_con_loadsig)
      2'b00: o_data_Wdata=i_data_Rdata;
      2'b10: o_data_Wdata={{24{i_data_Rdata[7]}},  i_data_Rdata[7:0]}; //byte
      2'b01: o_data_Wdata={{16{i_data_Rdata[15]}},  i_data_Rdata[15:0]}; //half
    endcase
  end 

endmodule
           