source library_Setup

analyze -format sverilog {./core.sv ./D_compare.sv ./D_control.sv ./D_jb_control.sv ./D_jump_ext.sv ./D_pcadd.sv ./D_register_bank.sv ./D_shiftleft.sv ./D_sign_extend.sv ./decode.sv ./E_alu.sv ./E_alu_control.sv ./E_alubmux.sv ./E_famux5.sv ./E_fbmux5.sv ./E_forward.sv ./E_rdmux.sv ./execute.sv ./F_add4.sv ./F_branchmux.sv ./F_jumpmux.sv ./F_pc.sv ./fetch.sv ./mem.sv ./W_datamux.sv ./W_loadmux3.sv ./W_resmux.sv ./writeback.sv}

elaborate core

create_clock clk -name clk -period 9
set_max_area 0

compile
report_area >   area_9ns.txt
report_power > power_9ns.txt
report_timing > time_9ns.txt
report_qor > summary_9ns.txt

change_names -rules verilog -hierarchy -verbose
write -f verilog -hierarchy -output "core_syn_9ns.v"
write_sdc design_9ns.sdc
write_sdf design_9ns.sdf