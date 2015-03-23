`timescale 1ns / 1ps
module D_shiftleft (input  [29:0] i_data_immE,
                   output [31:0] o_data_immshiftl);

  assign  o_data_immshiftl = {i_data_immE,2'b0};
endmodule
