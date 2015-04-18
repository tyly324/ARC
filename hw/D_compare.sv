module D_compare
(output logic o_con_ifbranch,
 input  logic [31:0] i_data_rs,     // 25:21 
        logic [31:0] i_data_rt,     // 20:16     
        logic /*[2:0]*/ i_con_bop);     // come from branch_jump   

/*always_comb
	begin
		case(i_con_bop)
		  1  :	 begin if (i_data_rs == i_data_rt) o_con_ifbranch = 1; 
		                   else o_con_ifbranch = 0; end  //  beq  //

		  0  :  begin if (i_data_rs != i_data_rt) o_con_ifbranch = 1; 
		                   else o_con_ifbranch = 0; end  //  bne  //

		  default :  o_con_ifbranch = 0;
		endcase
	end*/

// wire hicmp, locmp;
// assign hicmp = (i_data_rs[31:16] == i_data_rt[31:16]) ? 1 : 0;
// assign hicmp = (i_data_rs[15:0] == i_data_rt[15:0]) ? 1 : 0;


// always_comb
// begin
// o_con_ifbranch = 0;
// if((i_con_bop&&(i_data_rs == i_data_rt)) || (~i_con_bop&&(i_data_rs != i_data_rt)))
// 	o_con_ifbranch = 1;
// end 

assign o_con_ifbranch = (i_con_bop^(i_data_rs == i_data_rt));

endmodule

