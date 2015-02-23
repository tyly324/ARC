////////////////////////////////////////////////
// Project: ARC MIPS processor 
// Designer: Zhiyuan Jiang
// Module: Register bank
// Description: 
//
// Vision: Ver 1.0.3 - Add reset signal
// Comments: Sythesisable
//
////////////////////////////////////////////////
//Number	Name		Comments
//	0		$zero		Always zero
//	1		$at			Reserved for assembler
// 2-3		$v0-$v1		First and second return values, respectively
// 4-7		$a0-$a3		First four arguments to functions
// 8-15		$t0-$t7		Temporary registers
//16-23		$s0-$s7		Saved registers
//24-25		$t8-$t9		More temporary registers
//26-27		$k0-$k1		Reserved for kernel (operating system)
//	28		$gp			Global pointer
//	29		$sp			Stack pointer
//	30		$fp			Frame pointer
//	31		$ra			Return address
////////////////////////////////////////////////

module register_bank(
	input i_clk,
	input i_rst_n,

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
assign o_data_Rt = regs[i_addr_Rt];
assign o_data_Rs = regs[i_addr_Rs];

//Register write
always_ff @(posedge i_clk or negedge i_rst_n) 
begin : reg_write
	if(~i_rst_n) begin
		regs[i_addr_Rd] <= 0;
	end 
	else if (i_con_RegWr) begin
		regs[i_addr_Rd] <= i_data_Rd;;
	end
end

endmodule