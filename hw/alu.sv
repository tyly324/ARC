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
module alu(output logic [31:0] o_data_AluRes, output logic o_con_Zero, input logic [31:0]i_data_A, [31:0]i_data_B, input logic [3:0]i_con_AluCtrl);

always_comb
	begin: COM 
		o_con_Zero = (o_data_AluRes==0) ? 1:0;
		case(i_con_AluCtrl)
			0:	o_data_AluRes = i_data_A & i_data_B;
			1:	o_data_AluRes = i_data_A | i_data_B;
			2:	o_data_AluRes = i_data_A + i_data_B;
			6:	o_data_AluRes = i_data_A - i_data_B;
			7:	o_data_AluRes = (i_data_A < i_data_B) ? 1:0;
			12:	o_data_AluRes = ~(i_data_A|i_data_B);
			13: o_data_AluRes = i_data_A ^ i_data_B;
			default: o_data_AluRes = 0;
		endcase
	end
endmodule