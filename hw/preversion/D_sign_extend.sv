`timescale 1ns / 1ps
module D_sign_extend(input [15:0] i_data_immD,
                     input   i_con_signext,
    
                     output reg [31:0] o_data_immD);
                   

assign o_data_immD =( i_con_signext ? {{16{i_data_immD[15]}}, i_data_immD[15:0]} : {16'b0, i_data_immD[15:0]});
       
endmodule



