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

module sign_extand(input [15:0] i_data_immD,
                   input i_con_signext,clock,
                   output reg [31:0] o_data_immD);
                   
always_ff @(posedge clock)
	begin
		   if (i_con_signext)  o_data_immD <= {{16{i_data_immD[15]}}, i_data_immD[15:0]};
	       else                o_data_immD <= {16'b0, i_data_immD[15:0]};
	end

endmodule