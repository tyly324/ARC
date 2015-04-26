`timescale 1ns / 1ps
module D_forward(
  input logic [4:0] i_addr_rs, 
  input logic [4:0] i_addr_rt, 
  input logic [4:0] i_addr_rdE, 
  input logic [4:0] i_addr_rdM, 
  input logic [4:0] i_addr_rtM, 
  input logic [4:0] i_addr_rtW,
  input logic i_con_regwriteE, 
  input logic i_con_regwriteM, 
  input logic i_con_memreadM, 
  input logic i_con_memreadW,
  output logic [1:0] o_con_fa, 
  output logic [1:0] o_con_fb,
  output logic o_con_famem,
  output logic o_con_fbmem
  );

always_comb //fa
begin
  o_con_fa = 2'b00;    //choose rs
  o_con_famem = 0;
  //memout in mem stage
  if((i_addr_rs!=0)&&(i_addr_rs==i_addr_rtM)&&(i_con_memreadM==1))
  begin
    o_con_fa = 2'b11;
    o_con_famem = 0;
  end
  //memout in wb stage
  else if((i_addr_rs!=0)&&(i_addr_rs==i_addr_rtW)&&(i_con_memreadW==1))
  begin
    o_con_fa = 2'b11;
    o_con_famem = 1;
  end 
  //alures in ex stage
  else if((i_addr_rdE!=0)&&(i_addr_rdE==i_addr_rs)&&(i_con_regwriteE==1))
    o_con_fa = 2'b10;
  //alures in mem stage
  else if((i_addr_rdM!=0)&&(i_addr_rdM==i_addr_rs)&&(i_con_regwriteM==1))
    o_con_fa = 2'b01;
end 

always_comb 
begin //fb
  o_con_fb = 2'b00;    //choose rs
  o_con_fbmem = 0;
  if((i_addr_rt!=0)&&(i_addr_rt==i_addr_rtM)&&(i_con_memreadM==1))
  begin 
    o_con_fb = 2'b11;
    o_con_fbmem = 0;
  end 
  else if((i_addr_rt!=0)&&(i_addr_rt==i_addr_rtW)&&(i_con_memreadW==1))
  begin 
    o_con_fb = 2'b11;
    o_con_fbmem = 1;
  end 
  //EX hazard
  else if((i_addr_rt!=0)&&(i_addr_rt==i_addr_rdE)&&(i_con_regwriteE==1))
    o_con_fb = 2'b10;
  //MEM hazard
  else if((i_addr_rt!=0)&&(i_addr_rt==i_addr_rdM)&&(i_con_regwriteM==1))
    o_con_fb = 2'b01;
end 

endmodule
//*********************Topology*****************
//alu result    ===> alu input      (rs, rt)
//memory output ===> alu input      (rs, rt)
//alu result    ===> compare input  (rs)
//memory output ===> compare input  (rs)