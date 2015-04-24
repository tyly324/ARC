module E_counter (
	output logic o_con_pause, 
	input logic i_con_mul, 
	input logic i_clk, 
	input logic i_nrst);

logic state;
logic [3:0]counter;

always_ff@(posedge i_clk, negedge i_nrst)
begin:SEQ
	if(~i_nrst)
		begin
			counter<=0;
			state<=0;
			o_con_pause<=0;
		end
	else
		begin
			case(state)
			0:begin
				if(i_con_mul)
					begin
						o_con_pause<=1;
						state<=1;
					end
				else
					begin
						o_con_pause<=0;
						state<=0;
					end
				end
			1:begin
				if(counter==8)
					begin
						o_con_pause<=0;
						state<=0;
					end
				else
					begin
						o_con_pause<=1;
						counter<=counter+1;
					end
				end
			endcase

		end
end

endmodule