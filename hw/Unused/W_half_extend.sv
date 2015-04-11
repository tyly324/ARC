module W_half_extend (input    logic  [31:0] readdata,
                      output    logic  [31:0] halfvalue);
              
 always_comb
 begin
      halfvalue = {{16{a[15]}},  a[15:0]};
end
endmodule