
module D_sign_extend(input [15:0] i_data_immD,
                     input [5:0]  i_data_opcode, 
                     input [5:0]  i_data_funct,
                     input        i_clk,
                     output reg [31:0] o_data_immD);
                   

  always_ff @(posedge i_clk)
	begin
	case(i_data_opcode)
      6'b001000: o_data_immD <= {{16{i_data_immD[15]}}, i_data_immD[15:0]};
	  6'b000000: if((i_data_funct==6'b100000)||(i_data_funct==6'b100010))
	             o_data_immD <= {{16{i_data_immD[15]}}, i_data_immD[15:0]}; 

	  default: o_data_immD <= {16'b0, i_data_immD[15:0]};
    endcase
	end

endmodule



