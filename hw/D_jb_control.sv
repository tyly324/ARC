module D_jb_control
(output logic [1:0] o_con_jump,
        logic [2:0] o_con_bop,
        logic o_con_aluPC4,//***********
 input  logic [5:0] i_con_instru,        // opcode
        logic [5:0] i_con_func,          // function code
        logic i_con_rt);           // 16th of the instruction

always_comb
begin
o_con_aluPC4 = 0;
o_con_bop = 0;
o_con_jump = 0;
  casez (i_con_instru)
///////////////////// branch and jump instructions //////////////////////////////////////////

    6'b000100  :  begin o_con_bop = 3'b001;
                         o_con_jump = 2'b00; end  // beq //

    6'b000101  :  begin o_con_bop = 3'b010;
                         o_con_jump = 2'b00; end  // bne //

    6'b000110  :  begin o_con_bop = 3'b011;
                         o_con_jump = 2'b00; end  // blez: branch if <=0 //

    6'b000111  :  begin o_con_bop = 3'b100;
                         o_con_jump = 2'b00; end  // bgtz: branch if >0 //

    6'b000010  :  begin o_con_bop = 3'b000;
                         o_con_jump = 2'b01; end  // j //

    6'b000011  :  begin o_con_bop = 3'b000;
                         o_con_jump = 2'b01; 
                         o_con_aluPC4 = 1; end  // jal //

    6'b000001  :  begin if (~i_con_rt) begin
                         o_con_bop = 3'b101;
                         o_con_jump = 2'b00; end  // bltz: branch if <0 //
                         else begin
                         o_con_bop = 3'b110;
                         o_con_jump = 2'b00; end  // bgez: branch if >=0 //
                         end 

    6'b000000  :  begin if (i_con_func == 001000)
                        o_con_bop = 3'b000;
                        o_con_jump = 2'b10;  end  // jr  //

  endcase
end
endmodule