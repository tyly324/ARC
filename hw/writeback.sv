//resmux
//loadmux

module writeback(
	input logic [31:0] i_data_alures,
	input logic [31:0] i_data_memout,
	input logic [1:0] i_con_Wloadmux,
	input logic i_con_Wmemtoreg,

	output logic [31:0] o_data_regwrite

	);

// ====================
// I/O
// ====================
//resmux
wire [31:0] resmux_i_data_aluresW;
wire [31:0] resmux_i_data_readW;
wire resmux_i_con_memtoreg;
wire [31:0] resmux_o_data_result;

//loadmux
wire [31:0] loadmux_i_data_Rdata;
wire [1:0]  loadmux_i_con_loadsig;
wire [31:0] loadmux_o_data_Wdata;


// ====================
// Interconnection
// ====================
//resmux
assign resmux_i_data_aluresW = i_data_alures;
assign resmux_i_data_readW = loadmux_o_data_Wdata;
assign resmux_i_con_memtoreg = i_con_Wmemtoreg;

//loadmux
assign loadmux_i_data_Rdata = i_data_memout;
assign loadmux_i_con_loadsig = i_con_Wloadmux;

//output
assign o_data_regwrite = resmux_o_data_result;
// ====================
// Hirearchy
// ====================
//resmux
W_resmux u_resmux(
.i_data_aluresW(resmux_i_data_aluresW), 
.i_data_readW(resmux_i_data_readW), 
.i_con_memtoreg(resmux_i_con_memtoreg), 
.o_data_result(resmux_o_data_result)
);

//loadmux
W_loadmux3 u_loadmux(
.i_data_Rdata(loadmux_i_data_Rdata),
.i_con_loadsig(loadmux_i_con_loadsig), 
.o_data_Wdata(loadmux_o_data_Wdata)
);


endmodule