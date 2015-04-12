module multiply_multi (output logic [40:0]C1, C2, C3, C4, input wire [31:0] A, input wire [31:0] B);
always_comb
begin: COM 
	C1 = A [31:0] * B [7:0];
	C2 = A [31:0] * B [15:8];
	C3 = A [31:0] * B [23:16];
	C4 = A [31:0] * B [31:24];
end

endmodule