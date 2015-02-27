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
module alu_control(output logic [3:0] o_con_AluCtrl, input logic [1:0] i_con_AluOp, input logic [5:0] i_con_FuncCode, input logic [3:0] i_con_Other);
always_comb
	begin:COM 
		case(i_con_AluOp)
			2'b00:	o_con_AluCtrl=2; 	//LW SW / add
			2'b01:	o_con_AluCtrl=6;	//BEQ /sub
			2'b10:	begin				//R
					case(i_con_FuncCode)
						0:	o_con_AluCtrl=3; 	//R /sll(shift left logic)
						2:	o_con_AluCtrl=4; 	//R /srl(shift right logic)
						///////////////////////////////////////
						//8:	o_con_AluCtrl=14; 	//R /jr (jump register)
						///////////////////////////////////////
						32,33:	o_con_AluCtrl=2;	//R /add /addu	
						34,35:	o_con_AluCtrl=6;	//R /sub /subu
						///////////////////////////////////////
						36:	o_con_AluCtrl=0;	//R /AND
						37:	o_con_AluCtrl=1;	//R /OR
						38:	o_con_AluCtrl=13;	//R /xor
						39:	o_con_AluCtrl=12;	//R /nor
						///////////////////////////////////////
						42,43:	o_con_AluCtrl=7;	//R /slt(set on less than) /sltu 

						
						default:   	o_con_AluCtrl=15; 	//shouldnt happend
					endcase
					end
			2'b11:  begin
			        case(i_con_Other)
                        0:  o_con_AluCtrl=2;    // addi
                        ///////////////////////////////////////
                        1:  o_con_AluCtrl=0;    // andi
                        2:  o_con_AluCtrl=1;    // ori
                        3:  o_con_AluCtrl=13;   // xori
                        ///////////////////////////////////////
                        4:  o_con_AluCtrl=6;    // beq
                        ///////////////////////////////////////
                        6:  o_con_AluCtrl=7;    // slti
                    endcase
			        end
			default:	o_con_AluCtrl=15;
		endcase
	end
endmodule