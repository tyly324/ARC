`timescale 1ns / 1ps

module E_mulc_a (input logic [7:0]A, [7:0]B, output logic [11:0]C, output logic [11:0]D);
assign C = A*B[0]+ {A*B[1], 1'b0} + {A*B[2], 2'b0} + {A*B[3], 3'b0};
assign D = A*B[4]+ {A*B[5], 1'b0} + {A*B[6], 2'b0} + {A*B[7], 3'b0};
endmodule