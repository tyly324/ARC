module D_compare
(output logic o_con_ifbranch,
 input  logic [31:0] i_data_rs,     // 25:21 
        logic [31:0] i_data_rt,     // 20:16     
        logic [1:0] i_con_bop);     // come from branch_jump   


always_comb 
begin
	if(i_con_bop[1])
		o_con_ifbranch = (i_con_bop[0]^(i_data_rs == i_data_rt));
	else 
		o_con_ifbranch = 1;
end 


endmodule

