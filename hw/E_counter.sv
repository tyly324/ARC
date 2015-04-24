module E_counter (
	output logic o_con_pause, 
	input logic i_con_mul, 
	input logic i_clk, 
	input logic i_nrst);

state enum{IDLE, MUL};
logic counter;

always_ff@(posedge i_clk, negedge i_nrst);
begin
	if(~i_nrst)
		begin
			counter<=0;
			state<=IDLE;
			o_con_pause<=0;
		end
	else
		begin
			case(state)
			IDLE:begin
				if(i_con_mul)
					begin
						o_con_pause<=1;
						state<=MUL;
					end
				else
					begin
						o_con_pause<=0;
						state<=IDLE;
					end
				end
			MUL:begin
				if(counter==6)
					begin
						o_con_pause<=0;
						state<=IDLE;
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