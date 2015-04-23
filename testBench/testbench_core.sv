`timescale 1ns / 1ps
module testbench_core;

//instruciton and data memories
logic [31:0] data_mem [0:100];

//input signals
logic clk;
logic rst_n;
logic [31:0] read_instruction;
logic [31:0] read_data;

//output signals
wire [31:0] instruction_address;
wire [31:0] data_address;
wire [31:0] write_data;
wire mem_write;
wire mem_read;


logic [31:0] progMem[0:2000];

integer f, n, i;

initial
begin
	f = $fopen("add", "rb");
	n = $fread(progMem, f);

$display("Loaded %0d entries", n);
for (i=1114; i<1295; i= i+1)
$display("%h",progMem[i]);
end


//initial
//  $readmemh("prog.dat", progMem);

//internal signals

wire [31:0] pc;
wire [31:0] p;

assign pc = instruction_address / 4;
wire [31:0] local_data_address;
assign local_data_address = data_address / 4;

//output instruction according to the program counter
assign p=pc+1114;
assign read_instruction = progMem[p];

//set the initial insturction and data memories
initial 
begin
	clk = 0;
	forever #50ns clk = ~clk;
end

//set the testbench procedure
initial
begin
	rst_n = 1;
	#100
	rst_n = 0;
	#100
	rst_n = 1;

	#20000
	$stop;
end

//set the data memory read/write behaviour
always_comb
begin
	if (mem_write)
		data_mem[local_data_address] <= write_data;

	if (mem_read)
		read_data <= data_mem[local_data_address];
	else
		read_data <= 'z;
end

//hierarchy the processor core
core u_core(.*);

endmodule