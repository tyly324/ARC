module D_compare
(output logic o_con_ifbranch,
 input  logic [31:0] i_data_rs,     // 25:21 
        logic [31:0] i_data_rt,     // 20:16     
        logic [2:0] i_con_bop);     // come from branch_jump   
        
// always_comb 
// begin

// case(i_con_bop)

// 3'b001 : begin if (i_data_rs == i_data_rt) o_con_ifbranch = 1;
//                else o_con_ifbranch = 0; end  // beq;
               
// 3'b010 : begin if (i_data_rs != i_data_rt) o_con_ifbranch = 1;
//                else o_con_ifbranch = 0; end  // bne

// 3'b011  :  begin if ((i_data_rs == 0)||(i_data_rs[31])) o_con_ifbranch = 1; 
// 		                   else o_con_ifbranch = 0; end  //  blez: branch if <=0 //

// 3'b100  :  begin if ((i_data_rs != 0)&&(~i_data_rs[31])) o_con_ifbranch = 1; 
// 		                   else o_con_ifbranch = 0; end  //  bgtz: branch if >0 //

// 3'b101  :  begin if (i_data_rs[31]) o_con_ifbranch = 1; 
// 		                   else o_con_ifbranch = 0; end  // bltz: branch if <0 //

// 3'b110  :  begin if (~i_data_rs[31]) o_con_ifbranch = 1; 
// 		                   else o_con_ifbranch = 0; end  // bgez: branch if >=0 //
		               
// default :  o_con_ifbranch = 0;
// 		  endcase
// end 
wire equal;
assign equal = (i_data_rs == i_data_rt);

always_comb 
begin
case(i_con_bop)

3'b001 : o_con_ifbranch = equal;
               
3'b010 : o_con_ifbranch = ~equal;

3'b011  : o_con_ifbranch = equal | i_data_rs[31];

3'b100  : o_con_ifbranch = ~(equal | i_data_rs[31]);

3'b101  : o_con_ifbranch = i_data_rs[31];

3'b110  : o_con_ifbranch = ~i_data_rs[31];
		               
default :  o_con_ifbranch = 0;
endcase
end 

endmodule