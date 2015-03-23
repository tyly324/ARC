`timescale 1ns / 1ps
module D_sign_extend(input [15:0] i_data_immD,
                   output reg [31:0] o_data_immD);
                   

assign o_data_immD = {{16{i_data_immD[15]}}, i_data_immD[15:0]};

endmodule