source library_Setup

analyze -format sverilog {./alu.sv ./alu_control.sv ./control.sv ./core.sv ./decode.sv ./EX_alumux.sv ./execute.sv ./EX_pcadd.sv ./EX_writemux.sv ./fetch.sv ./IF_pcadd.sv ./IF_pcmux.sv ./mem.sv ./pc.sv ./register_bank.sv ./shifterleft2.sv ./sign_extend.sv ./WB_resmux.sv ./write_back.sv}

elaborate core

create_clock clk -name clk -period 10
set_max_area 0
