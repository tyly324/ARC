`timescale 1ns / 1ps
module E_forward
              (input  logic[4:0] i_data_rs, i_data_rt, i_data_rdM, i_data_rdW,
               input  logic i_con_regwriteM, i_con_regwriteW,
               input logic i_con_alures,
               output logic [1:0] o_con_fa, o_con_fb);

// always_comb
// begin
//  o_con_fa=0;
//  o_con_fb=0;
//  //EX hazard
//           if((i_data_rdM!=0)&&(i_data_rdM==i_data_rs)&&(i_con_regwriteM==1))

//                       o_con_fa=2'b10;

//           else if((i_data_rdM!=0)&&(i_data_rdM==i_data_rt)&&(i_con_regwriteM==1))

//                       o_con_fb=2'b10;
// //MEM hazard
//           else if((i_data_rdW!=0)&&(i_data_rdW==i_data_rs)&&(i_con_regwriteW==1)&&((i_data_rdM==0)||(i_data_rdM!=i_data_rs)||(i_con_regwriteM==0)))

//                       o_con_fa=2'b01;

//           else if((i_data_rdW!=0)&&(i_data_rdW==i_data_rt)&&(i_con_regwriteW==1)&&((i_data_rdM==0)||(i_data_rdM!=i_data_rt)||(i_con_regwriteM==0)))

//                       o_con_fb=2'b01;
//  //no hazard
// end

always_comb //fa
begin
  //EX hazard
  if((i_data_rdM!=0)&&(i_data_rdM==i_data_rs)&&(i_con_regwriteM==1))
    o_con_fa = 2'b10;
  //MEM hazard
  else if((i_data_rdW!=0)&&(i_data_rdW==i_data_rs)&&(i_con_regwriteW==1))
    o_con_fa = 2'b01;
  else //choose rs
    o_con_fa = 2'b00;
end 

always_comb 
begin //fb
  if(i_con_alures) //choose immediate
    o_con_fb = 2'b11;
  //EX hazard
  else if((i_data_rdM!=0)&&(i_data_rdM==i_data_rt)&&(i_con_regwriteM==1))
    o_con_fb = 2'b10;
  //MEM hazard
  else if((i_data_rdW!=0)&&(i_data_rdW==i_data_rt)&&(i_con_regwriteW==1))
    o_con_fb = 2'b01;
  else //choose rt
    o_con_fb = 2'b00;
end 

endmodule
