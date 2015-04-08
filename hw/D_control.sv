`timescale 1ns / 1ps
module D_control
(output logic o_con_regdst, o_con_memread, o_con_memtoreg,  
        o_con_memwrite, o_con_alusrc, o_con_regwrite, 
        logic [5:0] o_con_aluop, 
 input  [5:0] i_con_instru);

//WB: o_con_memtoreg, o_con_regwrite, 2bits
//MB: o_con_memread, o_con_memwrite, 2bits
//EX: o_con_aluop, o_con_alusrc, o_con_regdst, 4bits

always_comb
begin
  o_con_regdst = 0;
  o_con_regwrite = 0;
  o_con_alusrc = 0;
  o_con_memread = 0;
  o_con_memwrite = 0;
  o_con_memtoreg = 0;
  o_con_aluop = 6'b000000;  

  casez (i_con_instru)
///////////////////// addition operations and R-type start //////////////////////////////////////////

    6'b001000  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 6'b000011;   end  // ADDI //////////

    6'b001001  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 6'b000011;  end  // ADDIU /////////

    6'b000000  :  begin o_con_regdst = 1;
                        o_con_regwrite = 1;
                        o_con_alusrc = 0;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 6'b000010;  end  // R-type command //

/////////////////// addition operations and R-type finished ///////////////////////////////////////


///////////////////// logical operations start/////////////////////////////////////////////////////////

    6'b001100  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 6'b000111;  end  // ANDI /////////

    6'b001101  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 6'b001011;   end  // ORI ///////////

    6'b001110  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 6'b001111;   end  // XORI /////////
// the instructions AND, OR, XOR, NOR, NOT, NOP are included in the R-type instructions //
// ANDI, ORI, XORI are set with aluop valu '11' //
// other value: ANDI 001; ORI 010; XORI 011 //
/*/////////////////// logical operations finished ////////////////////////////////////////////////////*/



///////////////////// load and store operations start////////////////////////////////////////////////////
    6'b100???  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 1;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 1;
                        o_con_aluop = 6'b000000;  end
///////////////////// load operations ////////////////////////////////////////////////////////////////////
    6'b101???  :  begin o_con_regdst = 0;
                        o_con_regwrite = 0;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 1;
                        o_con_memtoreg = 1;
                        o_con_aluop = 6'b000000;   end
///////////////////// store operations ///////////////////////////////////////////////////////////////////
/*/////////////////// load and store operations finished ///////////////////////////////////////////////*/

///////////////////// slti //////////////////////////////////////////////////////////////////////////////
    6'b001010  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_branch = 0;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 6'b011011;  end  // SLTI /////////
  endcase
end

endmodule
