`timescale 1ns / 1ps
module E_alu_control(
	output logic [3:0] o_con_AluCtrl, 
	input logic [5:0] i_con_AluOp, 
	input logic [5:0] i_con_FuncCode);

always_comb
	begin:COM 
		o_con_AluCtrl = 15;	//shouldnt happend
		case(i_con_AluOp[1:0])
			2'b00:	o_con_AluCtrl=2; 	//LW SW lbu lhbu / add
			//2'b01:	o_con_AluCtrl=6;	//sub
			2'b10:	begin				//R
					case(i_con_FuncCode)
						0:	o_con_AluCtrl=3; 	//R /sll(shift left logic)
						2:	o_con_AluCtrl=4; 	//R /srl(shift right logic)
						3:  o_con_AluCtrl=5;	//R /sra
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
						42: o_con_AluCtrl=9;	//R  /slt 
						43:	o_con_AluCtrl=7;	//R  /sltu 
					endcase
					end
			2'b11:  begin
			        case(i_con_AluOp[5:2])
                        0:  o_con_AluCtrl=2;    // addi
                        ///////////////////////////////////////
                        1:  o_con_AluCtrl=0;    // andi
                        2:  o_con_AluCtrl=1;    // ori
                        3:  o_con_AluCtrl=13;   // xori
                        ///////////////////////////////////////
                        //5:	o_con_AluCtrl=5; 	// bne
                        ///////////////////////////////////////
                        6:  o_con_AluCtrl=9;    // slti
                        7:	o_con_AluCtrl=8;	//I//lui
                        //8: 	o_con_AluCtrl=9;	//J//jal
                        9:	o_con_AluCtrl=7;	//sltiu
                    endcase
			        end
		endcase
	end
endmodule
