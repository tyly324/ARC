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
module alu(output logic [31:0] o_data_AluRes, output logic o_con_Zero, input logic [31:0]i_data_A, [31:0]i_data_B, input logic [3:0]i_con_AluCtrl, input logic [4:0] i_data_shamt);

always_comb
	begin: COM 
		o_con_Zero = (o_data_AluRes==0) ? 1:0;
		case(i_con_AluCtrl)
			0:	o_data_AluRes = i_data_A & i_data_B; 	//AND
			1:	o_data_AluRes = i_data_A | i_data_B;	//OR
			2:	o_data_AluRes = i_data_A + i_data_B;	//add,addu
			3:	o_data_AluRes = i_data_B <<i_data_shamt;//sll
			4:	o_data_AluRes = i_data_B >>i_data_shamt;//srl
			5:	o_data_AluRes = (i_data_A==i_data_B) ? 1:0;//for bne
			6:	o_data_AluRes = i_data_A - i_data_B;	//sub
			7:	o_data_AluRes = (i_data_A < i_data_B) ? 1:0;// slt, sltu
			12:	o_data_AluRes = ~(i_data_A|i_data_B);	//nor
			13: o_data_AluRes = i_data_A ^ i_data_B;	//xor
			//14: 										//jr (architecture modification expected)
			
			default: o_data_AluRes = 0;
		endcase
	end
endmodule