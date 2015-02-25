
`timescale 1ns / 1ps
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
		case(i_con_AluOp)
			2'b00:	o_con_AluCtrl=2; 	//LW SW / add
			2'b01:	o_con_AluCtrl=6;	//BEQ /sub
			2'b10:	begin				//R
					case(i_con_FuncCode)
						6'b100000:	o_con_AluCtrl=2;	//R /add	
						6'b100010:	o_con_AluCtrl=6;	//R /sub
						////////////////////////////////////////
						6'b100100:	o_con_AluCtrl=0;	//R /AND
						6'b100101:	o_con_AluCtrl=1;	//R /OR
						6'b100111:	o_con_AluCtrl=12;	//R /nor
						6'b100110:	o_con_AluCtrl=13;	//R /xor
						///////////////////////////////////////
						6'b101010:	o_con_AluCtrl=7;	//R /set on less than

						default:   	o_con_AluCtrl=15; 	//shouldnt happend
					endcase
				end
			default:	o_con_AluCtrl=15;
		endcase
	end
endmodule