module mul8(output logic [15:0]res, input logic [7:0]A, input logic [7:0]B
	);
logic [7:0] C_1, C_2, C_3, C_4, C_5, C_6, C_7, C_8;
logic [7:0] D_4, D_3, D_2, D_1;
logic [7:0] E_3, E_2, E_1;
logic [7:0] F_2, F_1, G;

always_comb
begin:COM 

	C_1 = A[7]*B;
	C_2 = A[6]*B;
	C_3 = A[5]*B;
	C_4 = A[4]*B;
	C_5 = A[4]*B;
	C_6 = A[3]*B;
	C_7 = A[2]*B;
	C_8 = A[1]*B;

	D_4 = C_1 + C_2;
	D_3 = C_3 + C_4;
	D_2 = C_5 + C_6;
	D_1 = C_7 + C_8;

	E_3 = D_4 + D_3;
	E_2 = D_3 + D_2;
	E_1 = D_2 + D_1;

	F_2 = E_3 + E_2;
	F_1 = E_2 + E_1;

	G = F_2 + F_1;
end

assign res = {C_1[7], D_4[7], E_3[7], F_2[7], G, F_1[0], E_1[0], D_1[0], C_8[0]};
	
endmodule 