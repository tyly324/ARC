module multiply(output wire [31:0] Hi, output wire [31:0] Lo, input wire [31:0] A, input wire [31:0] B, input wire clock);

wire [40:0] C1, C2, C3, C4;
wire [40:0] a, b, c, d;
logic [40:0] C_a, C_b, C_c, C_d;


assign a = C_a;
assign b = C_b;
assign c = C_c;
assign d = C_d;

multiply_multi U_multiply_multi(
.C1(C1),
.C2(C2), 
.C3(C3),
.C4(C4),
.A(A), 
.B(B)
);

multiply_add U_multiply_add(
.Hi(Hi),
.Lo(Lo),
.a(a),
.b(b),
.c(c),
.d(d)
);

always(posedge clock)
begin: SEQ
		begin
			C_a <= C1;
			C_b <= C2;
			C_c <= C3;
			C_d <= C4;
		end
end

endmodule