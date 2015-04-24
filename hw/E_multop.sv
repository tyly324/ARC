`timescale 1ns / 1ps

module E_multop (
	output logic [31:0]Hi, 
	output logic [31:0]Lo, 
	input logic [31:0]i_A, 
	input logic [31:0]i_B, 
	input logic clock,
	input logic n_rst
	);
logic [31:0] A, B;
logic [15:0]C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16;
logic [15:0]C_a, C_b, C_c, C_d, C_e, C_f, C_g, C_h, C_i, C_j, C_k, C_l, C_m, C_n, C_o, C_p;
logic [15:0]D1, D2, D3, D4;
logic [15:0]D_a, D_b, D_c, D_d;
logic [15:0]E1, E2, E3, E4;
logic [15:0]E_a, E_b, E_c, E_d;
logic [31:0]F1, F2, F_a, F_b;
logic [11:0]A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16;
logic [11:0]A_a, A_b, A_c, A_d, A_e, A_f, A_g, A_h, A_i, A_j, A_k, A_l, A_m, A_n, A_o, A_p;
logic [11:0]B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16;
logic [11:0]B_a, B_b, B_c, B_d, B_e, B_f, B_g, B_h, B_i, B_j, B_k, B_l, B_m, B_n, B_o, B_p;
always_ff@(posedge clock, negedge n_rst)
begin:SEQ
if(~n_rst) 
	begin
		A  <=0;
		B  <=0;
		A_a<=0;
		B_a<=0;
		A_b<=0;
		B_b<=0;
		A_c<=0;
		B_c<=0;
		A_d<=0;
		B_d<=0;
		A_e<=0;
		B_e<=0;
		A_f<=0;
		B_f<=0;
		A_g<=0;
		B_g<=0;
		A_h<=0;
		B_h<=0;
		A_i<=0;
		B_i<=0;
		A_j<=0;
		B_j<=0;
		A_k<=0;
		B_k<=0;
		A_l<=0;
		B_l<=0;
		A_m<=0;
		B_m<=0;
		A_n<=0;
		B_n<=0;
		A_o<=0;
		B_o<=0;
		A_p<=0;
		B_p<=0;
		C_a<=0;
		C_b<=0;
		C_c<=0;
		C_d<=0;
		C_e<=0;
		C_f<=0;
		C_g<=0;
		C_h<=0;
		C_i<=0;
		C_j<=0;
		C_k<=0;
		C_l<=0;
		C_m<=0;
		C_n<=0;
		C_o<=0;
		C_p<=0;
		D_a<=0;
		D_b<=0;
		D_c<=0;
		D_d<=0;
		E_a<=0;
		E_b<=0;
		E_c<=0;
		E_d<=0;
		F_b<=0;
		F_a<=0;
	end
else
	begin
	A  <=i_A;
	B  <=i_B;
	A_a<=A1;
	B_a<=B1;
	A_b<=A2;
	B_b<=B2;
	A_c<=A3;
	B_c<=B3;
	A_d<=A4;
	B_d<=B4;
	A_e<=A5;
	B_e<=B5;
	A_f<=A6;
	B_f<=B6;
	A_g<=A7;
	B_g<=B7;
	A_h<=A8;
	B_h<=B8;
	A_i<=A9;
	B_i<=B9;
	A_j<=A10;
	B_j<=B10;
	A_k<=A11;
	B_k<=B11;
	A_l<=A12;
	B_l<=B12;
	A_m<=A13;
	B_m<=B13;
	A_n<=A14;
	B_n<=B14;
	A_o<=A15;
	B_o<=B15;
	A_p<=A16;
	B_p<=B16;
	

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

	F_b <= F1;

	F_a <= F2;
	end

end
	
	E_mulc_a mulc_a0 (.A(A[7:0]), .B(B[7:0]), .C(A1), .D(B1));
	E_mulc_b mulc_b0 (.A(A_a), .B(B_a), .C(C1));

	E_mulc_a mulc_a1 (.A(A[15:8]), .B(B[7:0]), .C(A2), .D(B2));
	E_mulc_b mulc_b1 (.A(A_b), .B(B_b), .C(C2));

	E_mulc_a mulc_a2 (.A(A[7:0]), .B(B[15:8]), .C(A3), .D(B3));
	E_mulc_b mulc_b2 (.A(A_c), .B(B_c), .C(C3));

	E_mulc_a mulc_a3 (.A(A[15:8]), .B(B[15:8]), .C(A4), .D(B4));
	E_mulc_b mulc_b3 (.A(A_d), .B(B_d), .C(C4));

	E_mulc_a mulc_a4 (.A(A[7:0]), .B(B[23:16]), .C(A5), .D(B5));
	E_mulc_b mulc_b4 (.A(A_e), .B(B_e), .C(C5));

	E_mulc_a mulc_a5 (.A(A[15:8]), .B(B[23:16]), .C(A6), .D(B6));
	E_mulc_b mulc_b5 (.A(A_f), .B(B_f), .C(C6));

	E_mulc_a mulc_a6 (.A(A[7:0]), .B(B[31:24]), .C(A7), .D(B7));
	E_mulc_b mulc_b6 (.A(A_g), .B(B_g), .C(C7));

	E_mulc_a mulc_a7 (.A(A[15:8]), .B(B[31:24]), .C(A8), .D(B8));
	E_mulc_b mulc_b7 (.A(A_h), .B(B_h), .C(C8));

	E_mulc_a mulc_a8 (.A(A[23:16]), .B(B[7:0]), .C(A9), .D(B9));
	E_mulc_b mulc_b8 (.A(A_i), .B(B_i), .C(C9));	

	E_mulc_a mulc_a9 (.A(A[31:24]), .B(B[7:0]), .C(A10), .D(B10));
	E_mulc_b mulc_b9 (.A(A_j), .B(B_j), .C(C10));

	E_mulc_a mulc_a10 (.A(A[23:16]), .B(B[15:8]), .C(A11), .D(B11));
	E_mulc_b mulc_b10 (.A(A_k), .B(B_k), .C(C11));

	E_mulc_a mulc_a11 (.A(A[31:24]), .B(B[15:8]), .C(A12), .D(B12));
	E_mulc_b mulc_b11 (.A(A_l), .B(B_l), .C(C12));

	E_mulc_a mulc_a12 (.A(A[23:16]), .B(B[23:16]), .C(A13), .D(B13));
	E_mulc_b mulc_b12 (.A(A_m), .B(B_m), .C(C13));

	E_mulc_a mulc_a13 (.A(A[31:24]), .B(B[23:16]), .C(A14), .D(B14));
	E_mulc_b mulc_b13 (.A(A_n), .B(B_n), .C(C14));

	E_mulc_a mulc_a14 (.A(B[23:16]), .B(B[31:24]), .C(A15), .D(B15));
	E_mulc_b mulc_b14 (.A(A_o), .B(B_o), .C(C15));

	E_mulc_a mulc_a15 (.A(A[31:24]), .B(B[31:24]), .C(A16), .D(B16));
	E_mulc_b mulc_b15 (.A(A_p), .B(B_p), .C(C16));


    E_muld muld_0 (.A(C_c), .B(C_b), .C(C_a[15:8]), .D(D1));
    E_muld muld_1 (.A(C_g), .B(C_f), .C(C_e[15:8]), .D(D2));
    E_muld muld_2 (.A(C_k), .B(C_j), .C(C_i[15:8]), .D(D3));
    E_muld muld_3 (.A(C_o), .B(C_n), .C(C_m[15:8]), .D(D4));

    E_mule mule_0	(.A(D_a[15:8]), .B(C_d), .C(E1));
    E_mule mule_1	(.A(D_b[15:8]), .B(C_h), .C(E2));
    E_mule mule_2	(.A(D_c[15:8]), .B(C_l), .C(E3));
    E_mule mule_3	(.A(D_d[15:8]), .B(C_p), .C(E4));

    E_mulf mulf_0 (.B_a(E_b), .B_b(D_b[7:0]), .B_c(C_e[7:0]), .C_a(E_c), .C_b(D_c[7:0]), .C_c(C_i[7:0]), .D(F1));

    E_mula mula_0 (.A(E_a), .B(F_b), .C(F2));

    E_mulg mulg_0 (.A_a(E_d), .A_b(D_d[7:0]), .A_c(C_m[7:0]), .B(F_a[31:16]), .C(Hi));

    assign Lo = {F_a[15:0], D_a[7:0], C_a[7:0]};
    
endmodule