`timescale 1ns / 1ps
module D_control
(output logic o_con_regdst, o_con_memread, o_con_memtoreg,  
        o_con_memwrite, o_con_alusrc, o_con_regwrite, 
        logic [1:0] o_con_aluop, 
        logic [3:0] o_con_other,
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
  o_con_aluop = 2'b00;  
  o_con_other = 4'b0000;

  casez (i_con_instru)
///////////////////// addition operations and R-type start //////////////////////////////////////////

    6'b001000  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b11;  
                        o_con_other = 4'b0000; end  // ADDI //////////

    6'b001001  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b11;  
                        o_con_other = 4'b0000; end  // ADDIU /////////

    6'b000000  :  begin o_con_regdst = 1;
                        o_con_regwrite = 1;
                        o_con_alusrc = 0;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b10;  
                        o_con_other = 4'b0000; end  // R-type command //

/////////////////// addition operations and R-type finished ///////////////////////////////////////


///////////////////// logical operations start/////////////////////////////////////////////////////////

    6'b001100  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b11;  
                        o_con_other = 4'b0001; end  // ANDI /////////

    6'b001101  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b11;  
                        o_con_other = 4'b0010; end  // ORI ///////////

    6'b001110  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_aluop = 2'b11;  
                        o_con_other = 4'b0011; end  // XORI /////////
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
                        o_con_aluop = 2'b00;  
                        o_con_other = 4'b0000; end
///////////////////// load operations ////////////////////////////////////////////////////////////////////
    6'b101???  :  begin o_con_regdst = 0;
                        o_con_regwrite = 0;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 1;
                        o_con_memtoreg = 1;
                        o_con_aluop = 2'b00;  
                        o_con_other = 4'b0000; end
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
                        o_con_aluop = 2'b11;  
                        o_con_other = 4'b0110; end  // SLTI /////////
  endcase
end

endmodule
