module multiply_multi (output logic[40:0]C1, C2, C3, C4, C5, C6, C7, C8, input wire [31:0] A, input wire [31:0] B);
always_comb
begin: COM 
	C1 = A [31:0] * B [3:0];
	C2 = A [31:0] * B [7:4];
	C3 = A [31:0] * B [11:8];
	C4 = A [31:0] * B [15:12];
	C5 = A [31:0] * B [19:16];
	C6 = A [31:0] * B [23:20];
	C7 = A [31:0] * B [27:24];
	C8 = A [31:0] * B [31:28];
end

endmodule