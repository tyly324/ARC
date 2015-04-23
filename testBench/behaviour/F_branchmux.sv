module F_branchmux(
	input logic [31:0] i_addr_jumpmux,
	input logic [31:0] i_addr_b,
	input logic i_con_ifbranch,

	output logic [31:0] o_addr_nextpc
	);

//0-branch, 1-not branch!!!!!!!!!!!!
assign o_addr_nextpc = i_con_ifbranch ? i_addr_b : i_addr_jumpmux;

endmodule