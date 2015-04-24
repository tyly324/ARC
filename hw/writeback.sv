//resmux
//loadmux

module writeback(
	input logic [31:0] i_data_alures,
	input logic [31:0] i_data_memout,
	input logic i_con_Wmemtoreg,

	output logic [31:0] o_data_regwrite

	);

// ====================
// I/O
// ====================
//datamux
wire [31:0] datamux_i_data_alu;
wire [31:0] datamux_i_data_load;
wire datamux_i_con_memtoreg;
wire [31:0] datamux_o_data_toreg;

// ====================
// Interconnection
// ====================
//datamux
assign datamux_i_data_alu = i_data_alures;
assign datamux_i_data_load = i_data_memout;
assign datamux_i_con_memtoreg = i_con_Wmemtoreg;

//output
assign o_data_regwrite = datamux_o_data_toreg;

// ====================
// Hirearchy
// ====================
//datamux
W_datamux u_datamux(
.i_data_alu(datamux_i_data_alu), 
.i_data_load(datamux_i_data_load),
.i_con_memtoreg(datamux_i_con_memtoreg),
.o_data_toreg(datamux_o_data_toreg)
	);

endmodule