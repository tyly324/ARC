module mem(
	input logic i_clk,
	input logic i_nrst,
	input logic [31:0] i_data_alures,
	input logic [31:0] i_data_memout,
	input logic [4:0] i_addr_regdst,
	input logic [1:0] i_con_Wloadmux,
	input logic i_con_Wmemtoreg,
	input logic i_con_Wregwrite,

	output logic [31:0] o_data_alures,
	output logic [31:0] o_data_memout,
	output logic [4:0] o_addr_regdst,
	//control
	output logic [1:0] o_con_Wloadmux,
	output logic o_con_Wmemtoreg,
	output logic o_con_Wregwrite
	);
// ====================
// Registers
// ====================
//data & address
logic [31:0] pipe_data_alures;
logic [31:0] pipe_data_memout;
logic [4:0] pipe_addr_regdst;
//control
logic [1:0] pipe_con_Wloadmux;
logic pipe_con_Wmemtoreg;
logic pipe_con_Wregwrite;

always_ff @(posedge i_clk, negedge i_nrst)
begin
	if(~i_nrst) begin
		pipe_data_alures <= 0;
		pipe_data_memout <= 0;
		pipe_addr_regdst <= 0;
		pipe_con_Wloadmux <= 0;
		pipe_con_Wmemtoreg <= 0;
		pipe_con_Wregwrite <= 0;
	end
	else begin
		pipe_data_alures <= i_data_alures;
		pipe_data_memout <= i_data_memout;
		pipe_addr_regdst <= i_addr_regdst;
		pipe_con_Wloadmux <= i_con_Wloadmux;
		pipe_con_Wmemtoreg <= i_con_Wmemtoreg;
		pipe_con_Wregwrite <= i_con_Wregwrite;
	end
end

// ====================
// Interconnection
// ====================
assign o_data_alures = pipe_data_alures;
assign o_data_memout = pipe_data_memout;
assign o_addr_regdst = pipe_addr_regdst;
assign o_con_Wloadmux = pipe_con_Wloadmux;
assign o_con_Wmemtoreg = pipe_con_Wmemtoreg;
assign o_con_Wregwrite = pipe_con_Wregwrite;


endmodule