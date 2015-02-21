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
        o_con_aluop[4:0],
        i_con_instru[5:0),
//WB: o_con_memtoreg, o_con_regwrite,
//MB: o_con_memread, o_con_memwrite, o_con_branch,
//EX: o_con_aluop, o_con_alusrc, o_con_regdst,
