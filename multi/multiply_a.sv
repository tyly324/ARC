module multiply_a(output logic [31:0]Hi, output logic [31:0]Lo, input logic [31:0]A, input logic [31:0]B, input logic clock);
logic [15:0]C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16;
logic [15:0]C_a, C_b, C_c, C_d, C_e, C_f, C_g, C_h, C_i, C_j, C_k, C_l, C_m, C_n, C_o, C_p;
logic [15:0]D1, D2, D3, D4;
logic [15:0]D_a, D_b, D_c, D_d;
logic [15:0]E1, E2, E3, E4;
logic [15:0]E_a, E_b, E_c, E_d;
logic [31:0]F, F_a;



always_ff@(posedge clock)
begin:SEQ
	C_a <= C1;
	C_b <= C2;
	C_c <= C3;
	C_d <= C4;
	C_e <= C5;
	C_f <= C6;
	C_g <= C7;
	C_h <= C8;
	C_i <= C9;
	C_j <= C10;
	C_k <= C11;
	C_l <= C12;
	C_m <= C13;
	C_n <= C14;
	C_o <= C15;
	C_p <= C16;

	D_a <= D1;
	D_b <= D2;
	D_c <= D3;
	D_d <= D4;

	E_a <= E1;
	E_b <= E2;
	E_c <= E3;
	E_d <= E4;

	F_a <= F;
	

end

always_comb
begin:COM 
	C1 = A[7:0] * B[7:0];
	C2 = A[15:8] * B[7:0];
	C3 = A[7:0] * B[15:8];
	C4 = A[15:8] * B[15:8];

	C5 = A[7:0] * B[23:16];
	C6 = A[15:8] * B[23:16];
	C7 = A[7:0] * B[31:24];
	C8 = A[15:8] * B[31:24];

	C9 = A[23:16] * B[7:0];
	C10 = A[31:24] * B[7:0];
	C11 = A[23:16] * B[15:8];
	C12 = A[31:24] * B[15:8];

	C13 = A[23:16] * B[23:16];
	C14 = A[31:24] * B[23:16];
	C15 = A[23:16] * B[31:24];
	C16 = A[31:24] * B[31:24];

	D1 = C_c + C_b + C_a[15:8];
	D2 = C_g + C_f + C_e[15:8];
	D3 = C_k + C_j + C_i[15:8];
	D4 = C_o + C_n + C_m[15:8];

	E1 = D_a[15:8] + C_d;
	E2 = D_b[15:8] + C_h;
	E3 = D_c[15:8] + C_l;
	E4 = D_d[15:8] + C_p;

	F = E_a + {E_b, D_b[7:0], C_e[7:0]} + {E_c, D_c[7:0], C_i[7:0]};

	Lo = {F_a[15:0], D_a[7:0], C_a[7:0]};

	Hi = {E_d, D_d[7:0], C_m[7:0]} + F_a[31:16];


end
endmodule
