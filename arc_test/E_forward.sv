`timescale 1ns / 1ps
module E_forward(
  input logic [4:0] i_addr_rs, 
  input logic [4:0] i_addr_rt, 
  input logic [4:0] i_addr_rdM, 
  input logic [4:0] i_addr_rdW, 
  input logic [4:0] i_addr_rtM, 
  input logic [4:0] i_addr_rtW,
  input logic i_con_regwriteM, 
  input logic i_con_regwriteW, 
  input logic i_con_memreadM, 
  input logic i_con_memreadW,
  output logic [2:0] o_con_fa, 
  output logic [2:0] o_con_fb,
  output logic o_con_cmpalu,
  output logic o_con_cmpmem
  );

always_comb //fa
begin
  if((i_addr_rs!=0)&&(i_addr_rs==i_addr_rtM)&&(i_con_memreadM==1))
    o_con_fa = 3'b100;
  else if((i_addr_rs!=0)&&(i_addr_rs==i_addr_rtW)&&(i_con_memreadW==1))
    o_con_fa = 3'b101;
  //EX hazard
  else if((i_addr_rdM!=0)&&(i_addr_rdM==i_addr_rs)&&(i_con_regwriteM==1))
    o_con_fa = 3'b010;
  //MEM hazard
  else if((i_addr_rdW!=0)&&(i_addr_rdW==i_addr_rs)&&(i_con_regwriteW==1))
    o_con_fa = 3'b001;
  else //choose rs
    o_con_fa = 3'b000;
end 

always_comb 
begin //fb
  if((i_addr_rt!=0)&&(i_addr_rt==i_addr_rtM)&&(i_con_memreadM==1))
    o_con_fb = 3'b100;
  else if((i_addr_rt!=0)&&(i_addr_rt==i_addr_rtW)&&(i_con_memreadW==1))
    o_con_fb = 3'b101;
  //EX hazard
  else if((i_addr_rt!=0)&&(i_addr_rt==i_addr_rdM)&&(i_con_regwriteM==1))
    o_con_fb = 3'b010;
  //MEM hazard
  else if((i_addr_rt!=0)&&(i_addr_rt==i_addr_rdW)&&(i_con_regwriteW==1))
    o_con_fb = 3'b001;
  else //choose rt
    o_con_fb = 3'b000;
end 

always_comb   //forward alures to compare
begin 
  if((i_addr_rs!=0)&&(i_addr_rs==i_addr_rdM)&&(i_con_regwriteM==1))
    o_con_cmpalu = 1'b1;
  else 
    o_con_cmpalu = 1'b0;
end

always_comb   //forward memory_out to compare
begin 
  if((i_addr_rs!=0)&&(i_addr_rs==i_addr_rtM)&&(i_con_memreadM==1))
    o_con_cmpmem = 1'b1;
  else 
    o_con_cmpmem = 1'b0;
end


endmodule
//*********************Topology*****************
//alu result    ===> alu input      (rs, rt)
//memory output ===> alu input      (rs, rt)
//alu result    ===> compare input  (rs)
//memory output ===> compare input  (rs)