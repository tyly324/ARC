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
module control
(output o_con_regdst, o_con_branch, o_con_memread, o_con_memtoreg,  
        o_con_memwrite, o_con_alusrc, o_con_regwrite, 
        [1:0] o_con_aluop, 
 input  [5:0] i_con_instru);
//WB: o_con_memtoreg, o_con_regwrite, 2bits
//MB: o_con_memread, o_con_memwrite, o_con_branch, 3bits
//EX: o_con_aluop, o_con_alusrc, o_con_regdst, 4bits
