//resmux
//loadmux

module writeback(
	input logic [31:0] i_data_pc8,////////////
	input logic [31:0] i_data_alures,
	input logic [31:0] i_data_memout,
	input logic [1:0] i_con_Wloadmux,
	input logic i_con_Walupc8,/////////////
	input logic i_con_Wmemtoreg,

	output logic [31:0] o_data_regwrite

	);

// ====================
// I/O
// ====================
//resmux
wire [31:0] resmux_i_data_alures;
wire [31:0] resmux_i_data_pc8;
wire resmux_i_con_pc8;
wire [31:0] resmux_o_data_alu;
//loadmux
wire [31:0] loadmux_i_data_Rdata;
wire [1:0]  loadmux_i_con_loadsig;
wire [31:0] loadmux_o_data_Wdata;
//datamux
wire [31:0] datamux_i_data_alu;
wire [31:0] datamux_i_data_load;
wire datamux_i_con_memtoreg;
wire [31:0] datamux_o_data_toreg;

// ====================
// Interconnection
// ====================
//resmux
assign resmux_i_data_alures = i_data_alures;
assign resmux_i_data_pc8 = i_data_pc8;
assign resmux_i_con_pc8 = i_con_Walupc8;
//loadmux
assign loadmux_i_data_Rdata = i_data_memout;
assign loadmux_i_con_loadsig = i_con_Wloadmux;
//datamux
assign datamux_i_data_alu = resmux_o_data_alu;
assign datamux_i_data_load = loadmux_o_data_Wdata;
assign datamux_i_con_memtoreg = i_con_Wmemtoreg;

//output
assign o_data_regwrite = datamux_o_data_toreg;

// ====================
// Hirearchy
// ====================
//resmux
W_resmux u_resmux(
.i_data_alures(resmux_i_data_alures), 
.i_data_pc8(resmux_i_data_pc8), 
.i_con_pc8(resmux_i_con_pc8), 
.o_data_alu(resmux_o_data_alu)
	);

//loadmux
W_loadmux3 u_loadmux(
.i_data_Rdata(loadmux_i_data_Rdata),
.i_con_loadsig(loadmux_i_con_loadsig), 
.o_data_Wdata(loadmux_o_data_Wdata)
);

//datamux
W_datamux u_datamux(
.i_data_alu(datamux_i_data_alu), 
.i_data_load(datamux_i_data_load),
.i_con_memtoreg(datamux_i_con_memtoreg),
.o_data_toreg(datamux_o_data_toreg)
	);

endmodule