`timescale 1ns / 1ps

module E_mule (input logic [7:0]A, input logic [15:0]B, output logic [15:0]C);

assign C = A + B;

endmodule