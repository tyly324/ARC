
module E_famux5(
  input  logic[31:0] i_data_rs, 
  input logic [31:0] i_data_alures, 
  input logic [31:0] i_data_writeres,
  input logic [31:0] i_data_lwM,
  input logic [31:0] i_data_lwW,
  input  logic[2:0]  i_con_fa, 
  output logic[31:0] o_data_alusra);

  // always_comb
  // begin
  //  o_data_alusra=0;
  //   if(i_con_fa==2'b00)
  //      o_data_alusra=i_data_rs;
  //   if(i_con_fa==2'b10) 
  //      o_data_alusra=i_data_alures;
  //   if(i_con_fa==2'b01)
  //      o_data_alusra=i_data_writeres;
  // end 

always_comb
case(i_con_fa)
  3'b000 : o_data_alusra = i_data_rs;
  3'b001 : o_data_alusra = i_data_writeres;
  3'b010 : o_data_alusra = i_data_alures;
  3'b100 : o_data_alusra = i_data_lwM;
  3'b101 : o_data_alusra = i_data_lwW;
  default : o_data_alusra = i_data_rs;
endcase

endmodule
             

             