module State_Machine (
	input wire clk,
	output wire done,
	output reg en
);
	
	
	reg [1:0] state, nstate;
	reg [3:0] count;
	localparam start_bit = 2'b00, data_bit = 2'b01, parity = 2'b10, stop_bit = 2'b11;
	
	assign done = (state == 2'b00);
	
	always @ (*)
	begin
		state = nstate;		// assign the new state
	end
	
	always @ (negedge clk)	// negedge of the keyboard clock
	begin
		case (state)		
		start_bit: 		// start bit - just move to next state
			begin
				nstate <= data_bit;		
				en <= 1'b1;			// turn on the enable signal 1 period early
			end
						
		data_bit:	
			begin	// grab 8 data bits
				if (count < 4'b0111)	// loop 8 times
				begin
					en <= 1'b1;			// enable the shift register
					count <= count + 1'b1;
				end
				else
				begin
					en <= 1'b0;			// turn enable off after we have gotten the last bit
					count <= 4'b0000;
					nstate <= parity;
				end
			end
				
		parity:	
			begin		// get parity bit - just move on to next state
				nstate <= stop_bit;
				en <= 1'b0;
			end
		
		stop_bit:	
			begin		// get stop bit - moving on~
				nstate <= start_bit;
				en <= 1'b0;
			end
				
		default:
			begin	
				nstate <= start_bit;	// default state goes to looking for start bit
				count <= 4'b0000;		// reset count
				en <= 1'b0;				// disable shift register
			end
		endcase
	end
endmodule
