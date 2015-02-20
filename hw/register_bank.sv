module register_bank(
	input i_clk,

	input [4:0] i_addr_Rs,
	input [4:0] i_addr_Rt,


	input i_con_RegWr,
	input [4:0] i_addr_Rd,
	input [31:0] i_data_Rd,

	output [31:0] o_data_Rs,
	output [31:0] o_data_Rt
);

//32 registers each 32-bits long
logic [31:0] regs [31:0];

//Register data output 
assign o_data_Rt = regs(i_addr_Rt);
assign o_data_Rs = regs(i_addr_Rs);

//Register write
always_ff @(posedge i_clk) 
begin : reg_write
	if(i_con_RegWr) 
		regs(i_addr_Rd) <= i_data_Rd;
end

endmodule