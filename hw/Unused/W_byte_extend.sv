module W_byte_extend (input    logic  [31:0] readdata,
                      output    logic  [31:0] bytevalue);
              
 always_comb
 begin

 bytevalue = {{24{a[7]}},  a[7:0]};


end
endmodule