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

always
begin
  case (i_con_instru)
///////////////////// addition operations and R-type start //////////////////////////////////////////
    6'b001000  :  begin o_con_regdst <= 0;
                        o_con_regwrite <= 1;
                        o_con_alusrc <= 1;
                        o_con_branch <= 0;
                        o_con_memread <= 0;
                        o_con_memwrite <= 0;
                        o_con_memtoreg <= 0;
                        o_con_aluop <= 2'b00;  end
///////////////////// ADDI ///////////////////////////////////////////////////////////////////////////

    6'b001001  :  begin o_con_regdst <= 0;
                        o_con_regwrite <= 1;
                        o_con_alusrc <= 1;
                        o_con_branch <= 0;
                        o_con_memread <= 0;
                        o_con_memwrite <= 0;
                        o_con_memtoreg <= 0;
                        o_con_aluop <= 2'b00;  end
//////////////////// ADDIU ////////////////////////////////////////////////////////////////////////////

    6'b000000  :  begin o_con_regdst <= 1;
                        o_con_regwrite <= 1;
                        o_con_alusrc <= 0;
                        o_con_branch <= 0;
                        o_con_memread <= 0;
                        o_con_memwrite <= 0;
                        o_con_memtoreg <= 0;
                        o_con_aluop <= 2'b10;  end
///////////////////// R-type command //////////////////////////////////////////////////////////////////
/*/////////////////// addition operations and R-type finished ///////////////////////////////////////*/



///////////////////// logical operations start/////////////////////////////////////////////////////////
    6'b0011xx  :  begin o_con_regdst <= 0;
                        o_con_regwrite <= 1;
                        o_con_alusrc <= 1;
                        o_con_branch <= 0;
                        o_con_memread <= 0;
                        o_con_memwrite <= 0;
                        o_con_memtoreg <= 0;
                        o_con_aluop <= 2'b10;  end
//////////////////// ANDI ORI and XORI /////////////////////////////////////////////////////////////////

///////////////////// NOT //////////////////////////////////////////////////////////////////////////////
/*/////////////////// logical operations finished ////////////////////////////////////////////////////*/



///////////////////// load and store operations start////////////////////////////////////////////////////
    6'b100xxx  :  begin o_con_regdst <= 0;
                        o_con_regwrite <= 1;
                        o_con_alusrc <= 1;
                        o_con_branch <= 0;
                        o_con_memread <= 1;
                        o_con_memwrite <= 0;
                        o_con_memtoreg <= 1;
                        o_con_aluop <= 2'b00;  end 
///////////////////// load operations ////////////////////////////////////////////////////////////////////

    6'b101xxx  :  begin o_con_regdst <= 0;
                        o_con_regwrite <= 0;
                        o_con_alusrc <= 1;
                        o_con_branch <= 0;
                        o_con_memread <= 0;
                        o_con_memwrite <= 1;
                        o_con_memtoreg <= 1;
                        o_con_aluop <= 2'b00;  end 
///////////////////// store operations ///////////////////////////////////////////////////////////////////
/*/////////////////// load and store operations finished ///////////////////////////////////////////////*/
  
  endcase
end

endmodule
