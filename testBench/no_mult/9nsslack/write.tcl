create_clock clk -name clk -period 10
write -f verilog -hierarchy -output "core_syn_9nss.v"
write_sdc design_9nss.sdc
write_sdf design_9nss.sdf