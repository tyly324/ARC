testbench_core;

//instruciton and data memories
logic [31:0] instruction_mem [31:0];
logic [31:0] data_mem [31:0];

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
wire pc;
assign pc = instruction_address / 4;

//output instruction according to the program counter
assign read_instruction = instruction_mem(pc);

//set the initial insturction and data memories
initial 
begin
	instruction_mem = {,};
	data_mem = {,};
end

//set the clock to 100ns
always 
begin
	clk = 0;
	#50ns
	clk = ~clk;
end

//set the testbench procedure
initial
begin
	rst_n = 1;
	#100ns
	rst_n = 0;
	#100ns
	rst_n = 1;

	#4000
	$stop;
end

//set the data memory read/write behaviour
always_ff @(posedge clk) 
begin
	if (mem_write)
		data_mem(data_address) <= write_data;

	if (mem_read)
		read_data <= data_mem(data_address);
end

//hierarvhy the processor core
core u_core(.*);

endmodule