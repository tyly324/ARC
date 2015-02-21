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
module alu_control(output logic [3:0] o_con_AluCtrl, input logic [1:0] i_con_AluOp, input logic [5:0] i_con_FuncCode);
always_comb
	begin:COM 
		case({i_con_AluOp,i_con_FuncCode})
			00xxxxxx: 	o_con_AluCtrl=2; 	//LW SW / add
			01xxxxxx:	o_con_AluCtrl=6;	//BEQ /sub
			10xx0000:	o_con_AluCtrl=2;	//R /add	
			1xxx0010:	o_con_AluCtrl=6;	//R /sub
			10xx0100:	o_con_AluCtrl=0;	//R /AND
			10xx0101:	o_con_AluCtrl=1;	//R /OR
			1xxx1010:	o_con_AluCtrl=12;	//R /set on less than
			default:   	o_con_AluCtrl=15; 	//shouldnt happend
		endcase
	end
endmodule