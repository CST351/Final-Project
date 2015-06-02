module TFT_Touch_Controller (
	input wire clk,
	output reg Dout, en,
	output reg x, y
);
	
	localparam Start = 4'b0000, A2 = 4'b0001, A1 = 4'b0010, A0 = 4'b0011, Mode = 4'b0100, SFR_DFR = 4'b0101,
		PD1 = 4'b0110, PD0 = 4'b0111, Wait_1 = 4'b1000, Data = 4'b1001, Wait_2 = 4'b1010, Wait_3 = 4'b1011, Wait_4 = 4'b1100, Wait_5 = 4'b1101, Initial_state = 4'b1111;
	
	reg [3:0] State;	// have 1 state for each bit that needs to be sent
	reg [3:0] count;
	reg [1:0] xy_counter;	// 0 & 1 == x, 2 & 3 == y
	
	always @ (negedge clk)
	begin
		case (State)
		Initial_state:	begin State = Start; count = 4'b0000; xy_counter = 2'b00; end	// reset both counters
		Start:	State = A2;	// send start bit
		A2:		State = A1;	// send a2	- these are x and y requests
		A1: 		State = A0;	// send a1
		A0: 		State = Mode;	// send a0
		Mode: 	State = SFR_DFR;	// mode - 1 = 8bits
		SFR_DFR: 	State = PD1;	// reference mode
		PD1: 		State = PD0;	// power down mode
		PD0: 		State = Wait_1;	
		Wait_1:	State = Data;	// wait 1 clock cycle
		Data:	begin
				if (count < 7)	// stay in here for 8 clock cycles
				begin
					State = Data;
					count = count + 1'b1;	// increment counter
				end
				else
				begin
					State = Wait_2;	// reset counter and move on
					count = 4'b0000;
				end
			end
		Wait_2: 	begin 
			State = Wait_3;
			if (xy_counter == 1)	// if the second pass
					x = 1'b1;	// pulse x
				else if (xy_counter == 3)	// if 4th pass
					y = 1'b1;	// pulse y
				else	
					begin x = 1'b0; y = 1'b0; end	// otherwise dont pulse anything
			end
		Wait_3:	State = Wait_4;
		Wait_4:	State = Wait_5;
		Wait_5:  begin 
			State = Start; 	// restart state machine
			xy_counter = xy_counter + 1'b1; 	// increment xy counter
			end
		default: begin State = Initial_state; xy_counter = 2'b00; count = 4'b0000; end	// reset to initial state, reset xy_counter
		endcase
	end
	
	always @ (State)
	begin
		case (State)
		Initial_state:	begin	// do nothing
			Dout = 1'b0;
			en = 1'b0;
		end
		Start:	begin	
			Dout = 1'b1;	// send start bit
			en = 1'b0;
		end
		A2:	begin	
			if (xy_counter [1] != 1'b1)	// send bit depending on which x or y we are requesting
				Dout = 1'b1;	// x
			else
				Dout = 1'b0;	// y
			en = 1'b0;
		end
		A1: 	begin
			Dout = 1'b0;	
			en = 1'b0;
		end
		A0: 	begin	
			Dout = 1'b1;
			en = 1'b0;
		end		
		Mode: 	begin
			Dout = 1'b1;
			en = 1'b0;
		end
		SFR_DFR:	begin	// send bits
			Dout = 1'b0;
			en = 1'b0;
		end			
		PD1: 		begin
			Dout = 1'b0;
			en = 1'b0;
		end
		PD0: 		begin
			Dout = 1'b0;
			en = 1'b0;
		end
		Wait_1:	begin
			Dout = 1'b0;
			en = 1'b0;
		end
		Data:		begin
			Dout = 1'b0;
			en = (1'b1 & xy_counter[0]);	// enable only on the second and 4th pass
		end
		Wait_2: 	begin	
			Dout = 1'b0;
			en = 1'b0;
		end
		Wait_3: 	begin	
			Dout = 1'b0;
			en = 1'b0;
		end
		Wait_4:	begin
			Dout = 1'b0;
			en = 1'b0;
		end
		Wait_5: 	begin 
			Dout = 1'b0;
			en = 1'b0;
		end
		default: begin	
			Dout = 1'b0;
			en = 1'b0;	// default not enabled
			count = 2'b00;		
		end
		endcase
	end
endmodule
