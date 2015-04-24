`timescale 1ns / 1ps

module E_mulg (input logic [15:0]A_a, [7:0]A_b, [7:0]A_c, [15:0]B, output logic [31:0] C);

assign C = {A_a, A_b, A_c} + B;

endmodule