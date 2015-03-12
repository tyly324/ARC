module multiply_add (output wire [31:0] Hi, output wire [31:0] Lo, input wire [40:0] a, b, c, d);

logic [63:0] D;

assign Hi = D[63:32];
assign Lo = D[31:0];

always_comb
begin: COM 
	D = a + {b, 8'b0} + {c, 16'b0} + {d, 24'b0};
end

endmodule