module D_jb_control
(output logic [1:0] o_con_jump,
        logic [1:0] o_con_bop,
        logic o_con_aluPC4,//***********
 input  logic [5:0] i_con_instru,        // opcode
        logic [5:0] i_con_func          // function code
        //logic i_con_rt
        );           // 16th of the instruction

always_comb
begin
o_con_aluPC4 = 0;
o_con_bop = 0;
o_con_jump = 0;
  casez (i_con_instru)
///////////////////// branch and jump instructions //////////////////////////////////////////

    6'b000100  :  begin o_con_bop = 2'b11;
                        o_con_jump = 2'b00; end  // beq //

    6'b000101  :  begin o_con_bop = 2'b10;
                        o_con_jump = 2'b00; end  // bne //


    6'b000010  :  begin o_con_bop = 2'b00;
                        o_con_jump = 2'b01; end  // j //

    6'b000011  :  begin o_con_bop = 2'b00;
                        o_con_jump = 2'b01; 
                        o_con_aluPC4 = 1; end  // jal //

    6'b000000  :  begin if (i_con_func == 6'b001000) begin
                        o_con_bop = 2'b00;
                        o_con_jump = 2'b10;  end  // jr  //
                        end

    default : begin o_con_bop = 0;
        o_con_jump = 2'b11;
    end

  endcase
end
endmodule