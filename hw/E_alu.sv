`timescale 1ns / 1ps
module E_alu(
	output logic [31:0] o_data_AluRes, 
	input logic [31:0]i_data_A, 
	input logic [31:0]i_data_B,
	input logic [3:0]i_con_AluCtrl, 
	input logic [4:0] i_data_shamt);

logic [8:0] sum_1;
logic [8:0] pre_sum_2a;
logic [8:0] pre_sum_2b;
logic [8:0] pre_sum_3a;
logic [8:0] pre_sum_3b;
logic [7:0] pre_sum_4a;
logic [7:0] pre_sum_4b;
logic carry2, carry3;



logic [16:0] half_sub;
logic [15:0] pre_suba;
logic [15:0] pre_subb; 


assign sum_1 = i_data_A[7:0] + i_data_B[7:0];
assign pre_sum_2a = i_data_A[15:8]+ i_data_B[15:8];
assign pre_sum_2b = i_data_A[15:8]+ i_data_B[15:8]+ 1'b1;
assign pre_sum_3a = i_data_A[23:16]+ i_data_B[23:16];
assign pre_sum_3b = i_data_A[23:16]+ i_data_B[23:16]+ 1'b1;
assign pre_sum_4a = i_data_A[31:24]+ i_data_B[31:24];
assign pre_sum_4b = i_data_A[31:24]+ i_data_B[31:24]+ 1'b1;

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
					o_data_AluRes [7:0] = sum_1[7:0];

					{carry2, o_data_AluRes [15:8]}= sum_1[8] ? pre_sum_2b : pre_sum_2a;//add,addu

					{carry3, o_data_AluRes [23:16]}= carry2 ? pre_sum_3b : pre_sum_3a;

					o_data_AluRes [31:24]=carry3 ? pre_sum_4b : pre_sum_4a;	
					//o_data_AluRes = i_data_A + i_data_B;				
				end
				
			3:	o_data_AluRes = i_data_B <<i_data_shamt;//sll
			4:	o_data_AluRes = i_data_B >>>i_data_shamt;//srl
			5:	o_data_AluRes = i_data_B >>i_data_shamt;//sra
			6:	begin					
					o_data_AluRes [31:16]= half_sub[16] ? pre_subb : pre_suba;//sub, subu
					o_data_AluRes [15:0] = half_sub[15:0];
					//o_data_AluRes = i_data_A - i_data_B;
				end
			7:	o_data_AluRes = (i_data_A < i_data_B) ? 1:0;// sltu
			8:	o_data_AluRes = {i_data_B, 16'b0}; 		//I//lui;
			9: o_data_AluRes = (((i_data_A[31]^i_data_B[31])&&i_data_A[31])||(~(i_data_A[31]^i_data_B[31])&&(i_data_A<i_data_B)));//slt		
			12:	o_data_AluRes = ~(i_data_A|i_data_B);	//nor
			13: o_data_AluRes = i_data_A ^ i_data_B;	//xor
						
		endcase  
	end
endmodule
