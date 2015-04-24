`timescale 1ns / 1ps

module E_muld (input logic [15:0]A, [15:0]B, [7:0]C, output logic [15:0]D);

assign D = A + B + C;

endmodule