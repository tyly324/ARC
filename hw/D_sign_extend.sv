`timescale 1ns / 1ps
module D_sign_extend(input [15:0] i_data_immD,
                     input   i_con_signext,
                     input   i_clk,
                     output reg [31:0] o_data_immD);
                   

  always_ff @(posedge i_clk)
	begin
       
      if(i_con_signext)
       o_data_immD <= {{16{i_data_immD[15]}}, i_data_immD[15:0]};
      else
       o_data_immD <= {16'b0, i_data_immD[15:0]};

	end

endmodule



