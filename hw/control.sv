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
(output o_control_regdst, o_control_branch, o_control_memread, o_control_memtoreg, 
        o_control_memwrite, o_control_alusrc, o_control_regwrite,
        o_control_aluop[4:0],
        i_control_instru[5:0),
//WB: o_control_memtoreg, o_control_regwrite,
//MB: o_control_memread, o_control_memwrite, o_control_branch,
//EX: o_control_aluop, o_control_alusrc, o_control_regdst,
