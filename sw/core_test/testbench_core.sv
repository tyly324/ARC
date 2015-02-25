module testbench_core;

//instruciton and data memories
logic [31:0] instruction_mem [0:63];
logic [31:0] data_mem [0:63];

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

//internal signals
wire [31:0] pc;
assign pc = instruction_address / 4;
wire [31:0] local_data_address;
assign local_data_address = data_address / 4;

//output instruction according to the program counter
assign read_instruction = instruction_mem[pc];

//set the initial insturction and data memories
initial 
begin
	instruction_mem = {	
	32'h3c020000,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h24420024,32'h3c030000,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h24630004,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'hac620000,
	32'h34630000,32'h3484000f,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h3484000f,
	32'h3c020000,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h34420008,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'hac450000,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0
	};
	data_mem = {
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0,
	32'h0,32'h0,32'h0,32'h0
	};
end

//set the clock to 100ns
initial 
begin
	clk = 0;
	forever #50ns clk = ~clk;
end

//set the testbench procedure
initial
begin
	rst_n = 1;
	#100ns
	rst_n = 0;
	#100ns
	rst_n = 1;

	#6000ns
	$stop;
end

//set the data memory read/write behaviour
always_ff @(posedge clk) 
begin
	if (mem_write)
		data_mem[local_data_address] <= write_data;

	if (mem_read)
		read_data <= data_mem[local_data_address];
end

//hierarvhy the processor core
core u_core(.*);

endmodule