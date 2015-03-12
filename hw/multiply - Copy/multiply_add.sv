module multiply_add (output wire [31:0] Hi, output wire [31:0] Lo, input wire [35:0] a, b, c, d, e, f, g, h);

logic [63:0] D;

assign Hi = D[63:32];
assign Lo = D[31:0];

always_comb
begin: COM 
	D = a + {b, 4'b0} + {c, 8'b0} + {d, 12'b0} + {e, 16'b0} + {f, 20'b0} + {g, 24'b0} + {h, 28'b0};
end

endmodule