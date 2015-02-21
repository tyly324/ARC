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

module sign_extend(input [15:0] i_data_immD,
                   input i_con_signext,
                   output reg [31:0] o_data_immD);
                   

assign o_data_immD = {{16{i_data_immD[15]}}, i_data_immD[15:0]};

endmodule