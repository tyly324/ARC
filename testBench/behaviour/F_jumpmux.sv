module F_jumpmux(
	input logic [31:0] i_addr_j, 
	input logic [31:0] i_addr_jr,
	input logic [31:0] i_addr_pc4,
	input logic [1:0] i_con_jump,

	output logic [31:0] o_addr_jumpmux
	);

always_comb
begin 
	case(i_con_jump)
		2'b01 : o_addr_jumpmux = i_addr_j;
		2'b10 : o_addr_jumpmux = i_addr_jr;
		default : o_addr_jumpmux = i_addr_pc4;
	endcase
end 
endmodule	