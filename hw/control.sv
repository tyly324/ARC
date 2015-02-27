`timescale 1ns / 1ps
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
(output logic o_con_regdst, o_con_branch, o_con_memread, o_con_memtoreg,  
        o_con_memwrite, o_con_alusrc, o_con_regwrite, 
       logic [1:0] o_con_aluop, 
 input  [5:0] i_con_instru);
//WB: o_con_memtoreg, o_con_regwrite, 2bits
//MB: o_con_memread, o_con_memwrite, o_con_branch, 3bits
//EX: o_con_aluop, o_con_alusrc, o_con_regdst, 4bits

always_comb
begin
    o_con_regdst = 0;
    o_con_regwrite = 0;
    o_con_alusrc = 0;
    o_con_branch = 0;
    o_con_memread = 0;
    o_con_memwrite = 0;
    o_con_memtoreg = 0;
    o_con_aluop = 2'b00;
  casez (i_con_instru)
///////////////////// addition operations and R-type start //////////////////////////////////////////
    6'b001000  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_branch = 0;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b00;  end
///////////////////// ADDI ///////////////////////////////////////////////////////////////////////////
    6'b001001  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_branch = 0;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b00;  end
//////////////////// ADDIU ////////////////////////////////////////////////////////////////////////////
    6'b000000  :  begin o_con_regdst = 1;
                        o_con_regwrite = 1;
                        o_con_alusrc = 0;
                        o_con_branch = 0;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b10;  end
///////////////////// R-type command //////////////////////////////////////////////////////////////////
//
    6'b011???  :  begin o_con_regdst = 1;
                        o_con_regwrite = 1;
                        o_con_alusrc = 0;
                        o_con_branch = 0;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b10;  end
///////////////////// R-type command //////////////////////////////////////////////////////////////////
///////////////////// madd, maddu, mul, msub, msubu, clz, clo, and I don't know if this is right //////
/*/////////////////// addition operations and R-type finished ///////////////////////////////////////*/



///////////////////// logical operations start/////////////////////////////////////////////////////////
    6'b0011??  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_branch = 0;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b10;  end
//////////////////// ANDI ORI and XORI /////////////////////////////////////////////////////////////////
///////////////////// NOT //////////////////////////////////////////////////////////////////////////////
/*/////////////////// logical operations finished ////////////////////////////////////////////////////*/



///////////////////// load and store operations start////////////////////////////////////////////////////
    6'b100???  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_branch = 0;
                        o_con_memread = 1;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 1;
                        o_con_aluop = 2'b00;  end 
///////////////////// load operations ////////////////////////////////////////////////////////////////////
    6'b101???  :  begin o_con_regdst = 0;
                        o_con_regwrite = 0;
                        o_con_alusrc = 1;
                        o_con_branch = 0;
                        o_con_memread = 0;
                        o_con_memwrite = 1;
                        o_con_memtoreg = 1;
                        o_con_aluop = 2'b00;  end 
///////////////////// store operations ///////////////////////////////////////////////////////////////////
/*/////////////////// load and store operations finished ///////////////////////////////////////////////*/



///////////////////// branch operations ///////////////////////////////////////////////////////////////////
/*    6'b000100  :  begin o_con_regdst = 0;
                        o_con_regwrite = 0;
                        o_con_alusrc = 0;
                        o_con_branch = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b01;  end*/
///////////////////// beq, b, beqz, bgez, bgtz operations /////////////////////////////////////////////////
    6'b000100  :  begin o_con_regdst = 0;
                        o_con_regwrite = 0;
                        o_con_alusrc = 0;
                        o_con_branch = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b11;  end  //aluop = 11, as i planned//
///////////////////// bne, bnez, blez, bltz operations ////////////////////////////////////////////////////
//as alu.sv state there are 3 situations in which zero will be 0://
//1. The calculation result is actually zero, and the zero will not be used as a signal for judge condition such as 'if ()'//
//this zero will not cause branch, however, because the 'branch' output from 'control' will be 1 to stop the branch//
//2. The calculation result is zero, excutions like branch or others stuff will be made if 'zero' is set//
//3. Opposite to 2 next step will be taken if 'zero' is 0//
//for 3 I suggest we set aluop '11' for this kind of instructions//
  
  endcase
end

endmodule
