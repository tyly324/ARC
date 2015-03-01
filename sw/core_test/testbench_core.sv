`timescale 1ns / 1ps
module testbench_core;

//instruciton and data memories
logic [31:0] instruction_mem [0:63];
logic [31:0] data_mem [0:63]= {
/*0*/	32'd8,32'd100,32'd0,32'd0,
/*16*/	32'd1,32'd2,32'd0,32'd0,
/*32*/	32'd0,32'd0,32'd0,32'd0,
/*48*/	32'd0,32'd0,32'd0,32'd0,
/*64*/	32'd0,32'd0,32'd0,32'd0,
/*80*/	32'd0,32'd0,32'd0,32'd0,
/*96*/	32'd0,32'd0,32'd0,32'd0,
/*112*/	32'd0,32'd0,32'd0,32'd0,
/*128*/	32'd0,32'd0,32'd0,32'd0,
/*144*/	32'd0,32'd0,32'd0,32'd0,
/*160*/	32'd0,32'd0,32'd0,32'd0,
/*176*/	32'd0,32'd0,32'd0,32'd0,
/*192*/	32'd0,32'd0,32'd0,32'd0,
/*208*/	32'd0,32'd0,32'd0,32'd0,
/*224*/	32'd0,32'd0,32'd0,32'd0,
/*240*/	32'd0,32'd0,32'd0,32'd0
};

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
	32'h8c020000,32'h8c030004,32'h0,32'h0,
//lw $v0 #0; lw $v1 #4
	32'h0,32'h0,32'h0,32'h0,
//wait more than five clock, to avoid hazard
	32'hac430000,32'h0,32'h0,32'h0,
//sw $v1, ($v0)
	32'h8c080010,32'h8c090014,32'h0,32'h0,
//lw $t0 0x0010; lw  $t1 0x0014
	32'h0,32'h0,32'h0,32'h0,
////wait more than five clock, to avoid hazard
	32'h01288020,32'h01288825,32'h01289024,32'h00099842,
//add $s0,$t1,$t0; or $s1,$t1,$t0; and $s2,$t1,$t0; srl$s3,$t1,#1
	32'h0009a040,32'h0128a82a,32'h0109b02a,32'h0128b827,
//sll $s4,$t1,#1; slt $s5,$t1,$t0; slt $s6,$t0,$t1; nor $s7,$t1,$t0
	32'h0128c026,32'h0128c822,32'h0109d022,32'h212a0001,
//xor $t8,$t1,$t0; sub $t9,$t1,$t0; sub $k0,$t0,$t1; addi $t2,$t1,#1
	32'h312b0001,32'h352c0001,32'h392d0001,32'h292e0004,
//andi $t3,$t1,#1; ori $t4,$t1,#1; xori $t5,$t1,#1; slti $t6,$t1,#4
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
	#100
	rst_n = 0;
	#100
	rst_n = 1;

	#6000
	$stop;
end

//set the data memory read/write behaviour
always_comb
begin
	if (mem_write)
		data_mem[local_data_address] <= write_data;

	if (mem_read)
		read_data <= data_mem[local_data_address];
end

//hierarchy the processor core
core u_core(.*);

endmodule