module D_compare
(output logic o_con_ifbranch,
 input  logic [31:0] i_data_rs,     // 25:21 
        logic [31:0] i_data_rt,     // 20:16     
        logic [1:0] i_con_bop);     // come from branch_jump   


/*                  3'b011  :  begin if ((i_data_rs == 0)||(i_data_rs[31])) o_con_ifbranch = 1; 
		                   else o_con_ifbranch = 0; end  //  blez: branch if <=0 //

		  3'b100  :  begin if ((i_data_rs != 0)&&(~i_data_rs[31])) o_con_ifbranch = 1; 
		                   else o_con_ifbranch = 0; end  //  bgtz: branch if >0 //

		  3'b101  :  begin if (i_data_rs[31]) o_con_ifbranch = 1; 
		                   else o_con_ifbranch = 0; end  // bltz: branch if <0 //

		  3'b110  :  begin if (~i_data_rs[31]) o_con_ifbranch = 1; 
		                   else o_con_ifbranch = 0; end  // bgez: branch if >=0 //*/


always_comb 
begin
	if(i_con_bop[1])
		o_con_ifbranch = (i_con_bop[0]^(i_data_rs == i_data_rt));
	else 
		o_con_ifbranch = 1;
end 


endmodule

