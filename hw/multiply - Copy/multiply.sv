module multiply(output wire [31:0] Hi, output wire [31:0] Lo, input wire [31:0] A, input wire [31:0] B, input wire clock);

wire [40:0] C1, C2, C3, C4, C5, C6, C7, C8;
wire [40:0] a, b, c, d, e, f, g, h;
logic [40:0] C_a, C_b, C_c, C_d, C_e, C_f, C_g, C_h;


assign a = C_a;
assign b = C_b;
assign c = C_c;
assign d = C_d;
assign e = C_e;
assign f = C_f;
assign g = C_g;
assign h = C_h;

multiply_multi U_multiply_multi(
.C1(C1),
.C2(C2), 
.C3(C3),
.C4(C4),
.C5(C5),
.C6(C6),
.C7(C7),
.C8(C8),
.A(A), 
.B(B)
);

multiply_add U_multiply_add(
.Hi(Hi),
.Lo(Lo),
.a(a),
.b(b),
.c(c),
.d(d),
.e(e),
.f(f),
.g(g),
.h(h)
);

always_ff@(posedge clock)
begin: SEQ
		begin
			C_a <= C1;
			C_b <= C2;
			C_c <= C3;
			C_d <= C4;
			C_e <= C5;
			C_f <= C6;
			C_g <= C7;
			C_h <= C8;
		end
end

endmodule