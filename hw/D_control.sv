`timescale 1ns / 1ps
module D_control
(output logic o_con_regdst, o_con_memread, o_con_memtoreg,  
        o_con_memwrite, o_con_alusrc, o_con_regwrite, 
        logic o_con_ifsign,
        //logic [1:0]o_con_loadsig,//********
        logic [5:0] o_con_aluop, 
 input  [5:0] i_con_instru);

//WB: o_con_memtoreg, o_con_regwrite, 2bits
//MB: o_con_memread, o_con_memwrite, 2bits
//EX: o_con_aluop, o_con_alusrc, o_con_regdst, 4bits

//check_add and sub:      addi---001000,  andiu---001001,  
//check_logic:            andi---001100,  ori  ---001101,  xori---001110
//check_store:            sb  ---101000,  sh   ---101001,  sw  ---101011,  sc ---111000
//check_load:             lb  ---100000,  lh   ---100001,  lw  ---100011,  lbu---100100,  lhu ---100101,  lui ---001111, 
//jump and branch:  j   ---000010,  jal  ---000011,  beq ---000100,  bne---000101,  blez---000110,  bgtz---000111,
//set less than:    slti---001010,  sltiu---001011,
//check_R-type


always_comb
begin
  o_con_regdst = 0;
  o_con_regwrite = 0;
  o_con_alusrc = 0;
  o_con_memread = 0;
  o_con_memwrite = 0;
  o_con_memtoreg = 0;
  o_con_ifsign = 0;
  o_con_aluop = 6'b000000;  
  //o_con_loadsig = 6'b00;

  casez (i_con_instru)
///////////////////// addition operations and R-type start //////////////////////////////////////////

    6'b001000  :  begin o_con_regdst = 0;           //0: result goes to 20:16(I-type);         1: result goes to 15:11(R-type);
                        o_con_regwrite = 1;         //0: result does not go to register(for example: store operation); 
                        o_con_alusrc = 1;           //0: second operand come from register(R-type); 
                        o_con_memread = 0;          //1: read data from memory
                        o_con_memwrite = 0;         //1: write data to memory
                        o_con_memtoreg = 0;         //0: write to register from result of ALU; 1: write to register from data memory;
                        o_con_ifsign = 1;           //0: no overflow;                          1: overflow
                        o_con_aluop = 6'b000011;    //the first 4 digit stand for different operation of ALU, the original 'other'
                                                    //first 4 digits: '0000'---addi, '0001'---andi, '0010'---ori, '0011'---xori
                                                    //'0110'---slti, '0111'---lui, '1000'---jal
                                                    //the last 2 digit is aluop '10'---R-type; '00'---lw/sw; '10'---other operations     
                                              end  // ADDI //////////

    6'b001001  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_ifsign = 1;
                        o_con_aluop = 6'b000011;  end  // ADDIU /////////

    6'b000000  :  begin o_con_regdst = 1;
                        o_con_regwrite = 1;
                        o_con_alusrc = 0;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_ifsign = 0;
                        o_con_aluop = 6'b000010;  end  // R-type command //

/////////////////// addition operations and R-type finished //////////////////////////////////////////

///////////////////// logical operations start/////////////////////////////////////////////////////////

    6'b001100  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_ifsign = 0;
                        o_con_aluop = 6'b000111;  end  // ANDI /////////

    6'b001101  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_ifsign = 0;
                        o_con_aluop = 6'b001011;   end  // ORI ///////////

    6'b001110  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_ifsign = 0;
                        o_con_aluop = 6'b001111;   end  // XORI /////////

// the instructions AND, OR, XOR, NOR, NOT, NOP are included in the R-type instructions //
// ANDI, ORI, XORI are set with aluop valu '11' //
// other value: ANDI 001; ORI 010; XORI 011 //
/*/////////////////// logical operations finished ///////////////////////////////////////////////////*/

///////////////////// load and store operations start//////////////////////////////////////////////////

    /*6'b100???  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 1;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 1;
                        o_con_ifsign = 0;
                        o_con_aluop = 6'b000000;  end  // load operations /////////*/

    6'b100011  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 1;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 1;
                        o_con_ifsign = 1;
                        o_con_aluop = 6'b000000;  end  // lw /////////**************

    /*6'b100100  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 1;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 1;
                        o_con_ifsign = 1;
                        o_con_aluop = 6'b000000;
                        o_con_loadsig = 2'b10;  end  // lbu /////////**************  

    6'b100101  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 1;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 1;
                        o_con_ifsign = 1;
                        o_con_aluop = 6'b000000;
                        o_con_loadsig = 2'b01;  end  // lhu /////////**************  */                    

    6'b101???  :  begin o_con_regdst = 0;
                        o_con_regwrite = 0;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 1;
                        o_con_memtoreg = 1;
                        o_con_ifsign = 1;
                        o_con_aluop = 6'b000000;   end  // store operations ////////

    6'b001111  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 1;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_ifsign = 1;
                        o_con_aluop = 6'b011111;   end  // lui ////////
/*/////////////////// load and store operations finished //////////////////////////////////////////////*/

///////////////////// slti //////////////////////////////////////////////////////////////////////////////
    6'b001010  :  begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_ifsign = 1;
                        o_con_aluop = 6'b011011;  end  // SLTI /////////

    6'b001011   : begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 1;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_ifsign = 0;
                        o_con_aluop = 6'b100111;  end  // SLTIU /////////


    6'b000011   : begin o_con_regdst = 0;
                        o_con_regwrite = 1;
                        o_con_alusrc = 0;
                        o_con_memread = 0;
                        o_con_memwrite = 0;
                        o_con_memtoreg = 0;
                        o_con_ifsign = 0;   end  // jal ////////
  endcase
end
endmodule