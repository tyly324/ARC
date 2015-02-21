////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: 
// Module: 
// Description: 
//
// Vision: Ver 1.0.0 - File Create
// Comments: 
//
////////////////////////////////////////////////
module pc_add(input [31:0] pc, 
              output [31:0] pcadd4);
      
    assign pcadd4 = pc + 32'b100;
    
endmodule
    
