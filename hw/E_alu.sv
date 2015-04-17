`timescale 1ns / 1ps
module E_alu(
	output logic [31:0] o_data_AluRes, 
	input logic [31:0]i_data_A, 
	input logic [31:0]i_data_B, 
	input logic [3:0]i_con_AluCtrl, 
	input logic [4:0] i_data_shamt);

logic [16:0] half_sum;
logic [15:0] pre_suma;
logic [15:0] pre_sumb;
logic [16:0] half_sub;
logic [15:0] pre_suba;
logic [15:0] pre_subb; 


assign half_sum = i_data_A[15:0] + i_data_B[15:0];
assign pre_suma = i_data_A[31:16]+ i_data_B[31:16];
assign pre_sumb = i_data_A[31:16]+ i_data_B[31:16]+ 1'b1;

assign half_sub = i_data_A[15:0] - i_data_B[15:0];
assign pre_suba = i_data_A[31:16]- i_data_B[31:16];
assign pre_subb = i_data_A[31:16]- i_data_B[31:16]- 1'b1;
always_comb
	begin: COM 
		o_data_AluRes = 0;
		

		case(i_con_AluCtrl)
			0:	o_data_AluRes = i_data_A & i_data_B; 	//AND
			1:	o_data_AluRes = i_data_A | i_data_B;	//OR

			2:	begin					
					o_data_AluRes [31:16]= half_sum[16] ? pre_sumb : pre_suma;//add,addu
					o_data_AluRes [15:0] = half_sum[15:0];
				end
			3:	o_data_AluRes = i_data_B <<i_data_shamt;//sll
			4:	o_data_AluRes = i_data_B >>>i_data_shamt;//srl
			5:	o_data_AluRes = i_data_B >>i_data_shamt;//sra
			//5:	o_data_AluRes = (i_data_A==i_data_B) ? 1:0;//for bne
			6:	begin					
					o_data_AluRes [31:16]= half_sub[16] ? pre_subb : pre_suba;//sub, subu
					o_data_AluRes [15:0] = half_sub[15:0];
				end
			7:	o_data_AluRes = (i_data_A < i_data_B) ? 1:0;// slt, sltu
			8:	o_data_AluRes = {i_data_B, 16'b0}; 		//I//lui;
			9: 	o_data_AluRes = i_data_A + 4;			//J//jal;			
			12:	o_data_AluRes = ~(i_data_A|i_data_B);	//nor
			13: o_data_AluRes = i_data_A ^ i_data_B;	//xor
			//14: o_data_AluRes = i_data_A;				//jr (architecture modification expected)
			
		endcase
	end
endmodule
