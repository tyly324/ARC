////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: 
// Module: 
// Description: 03/03/2015 select PC source from branch or jump register
//
// Vision: Ver 1.0.0 - File Create
// Comments: 
//
////////////////////////////////////////////////
module MEM_jrmux 
              (input  [31:0] i_addr_branch, i_data_rs, 
               input  [25:0] i_addr_JumpAddr,
               input         i_con_jumpr, i_con_jump,
               output [31:0] o_addr_JBpc);

  assign o_addr_JBpc = ({i_con_jumpr,i_con_jump}==0) ? i_addr_branch:
  					   ({i_con_jumpr,i_con_jump}==1) ? i_addr_JumpAddr:
  					   ({i_con_jumpr,i_con_jump}==2) ? i_data_rs; 

endmodule