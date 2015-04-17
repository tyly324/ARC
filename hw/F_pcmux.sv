module F_pcmux 
(input  logic [31:0] i_addr_jump,            //  come from the immediate address adder in ID state
        logic [31:0] i_addr_jumpr,           //  come from rs, register 25:21
        logic [31:0] i_addr_pc,              //  come from after pc + 4
        logic [31:0] i_addr_branch,           //  come from the branch adder
        logic [1:0]  i_con_jump,             //  come from branch_jump
        logic i_con_ifbranch,                //  come from branch_compare
 output logic [31:0] o_addr_nextpc);

  always_comb 
    begin
    	casez({i_con_jump, i_con_ifbranch})
    	  3'b010  :  begin o_addr_nextpc = i_addr_jump; end    //  j and jal instruction

    	  3'b100  :  begin o_addr_nextpc = i_addr_jumpr; end    //  jr instruction 

    	  3'b000  :  begin o_addr_nextpc = i_addr_pc; end     //  no jump 

          3'b??1  :  begin o_addr_nextpc = i_addr_branch; end    //  branch

    	  default : begin o_addr_nextpc = i_addr_pc; end
    	endcase
    end
endmodule        