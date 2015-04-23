
module D_shiftleft (input  [15:0] i_data_immE,
                   output [31:0] o_data_immshiftl);

  assign  o_data_immshiftl = {{14{i_data_immE[15]}}, i_data_immE, 2'b0};
  
endmodule