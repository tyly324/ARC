`timescale 1ns / 1ps

module E_mulc_b (input logic [11:0]A, [11:0]B, output logic [15:0]C);

assign C = A + {B, 4'b0};

endmodule