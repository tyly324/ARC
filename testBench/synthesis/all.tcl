source library_Setup

analyze -format sverilog {./core.sv ./D_compare.sv ./D_control.sv ./D_jb_control.sv ./D_jump_ext.sv ./D_pcadd.sv ./D_register_bank.sv ./D_shiftleft.sv ./D_sign_extend.sv ./decode.sv ./E_alu.sv ./E_alu_control.sv ./E_alubmux.sv ./E_famux5.sv ./E_fbmux5.sv ./E_forward.sv ./E_rdmux.sv ./execute.sv ./F_add4.sv ./F_branchmux.sv ./F_jumpmux.sv ./F_pc.sv ./fetch.sv ./mem.sv ./W_datamux.sv ./W_loadmux3.sv ./W_resmux.sv ./writeback.sv}

elaborate core

create_clock clk -name clk -period 4.5
set_max_area 0

compile
report_area >   area_4.5ns.txt
report_power > power_4.5ns.txt
report_timing > time_4.5ns.txt
report_qor > summary_4.5ns.txt

change_names -rules verilog -hierarchy -verbose
write -f verilog -hierarchy -output "core_syn_4.5ns.v"
write_sdc design_4.5ns.sdc
write_sdf design_4.5ns.sdf

create_clock clk -name clk -period 5.5
write_sdc design_4.5nss.sdc
write_sdf design_4.5nss.sdf