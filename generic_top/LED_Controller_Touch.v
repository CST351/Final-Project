 module LED_Controller_Touch (
	input reg [7:0] x_hold, y_hold,
	output reg right_button, up_button, left_button, down_button,
	output reg [7:0] LEDR, LEDG);

	always @ (x_hold or y_hold)
	begin
		if ((13 < y_hold) && (y_hold < 31))			// right
		begin
			if ((69 < x_hold) && (x_hold < 142))
				right_button = 1'b1;
			else 
				right_button = 1'b0;
			left_button = 1'b0;
			up_button = 1'b0;
			down_button = 1'b0;
		end
		
		else if ((74 < y_hold) && (y_hold < 153))	// up
		begin	
			if ((223 < x_hold) && (x_hold < 240))
			begin
				up_button = 1'b1;
				down_button = 1'b0;
			end
			else if ((26 < x_hold) && (x_hold < 43))	// down
			begin
				down_button = 1'b1;
				up_button = 1'b0;
			end
			else 
			begin
				up_button = 1'b0;
				down_button = 1'b0;
			end
			right_button = 1'b0;
			left_button = 1'b0;
		end
	
		else if ((211 < y_hold) && (y_hold < 240))	// left
		begin	
			if ((69 < x_hold) && (x_hold < 142))
				left_button = 1'b1;
			else	
				left_button = 1'b0;
			right_button = 1'b0;
			up_button = 1'b0;
			down_button = 1'b0;
		end
		
		else	
		begin 
			right_button = 1'b0;
			left_button = 1'b0;
			up_button = 1'b0;
			down_button = 1'b0;
		end

	end
	
endmodule	