 module LED_Controller_Touch (
	input  reg [7:0] x_hold, y_hold,
	output reg [3:0] dir
);

	always @ (x_hold or y_hold)
	begin
		if ((13 < y_hold) && (y_hold < 31))			// right
		begin
			if ((69 < x_hold) && (x_hold < 142))
				dir[3] = 1'b1;
			else 
				dir[3] = 1'b0;
			dir[2:0] = 1'b0;
		end
		
		else if ((74 < y_hold) && (y_hold < 153))	// up
		begin	
			if ((223 < x_hold) && (x_hold < 240))
			begin
				dir[0] = 1'b1;
				dir[1] = 1'b0;
			end
			else if ((26 < x_hold) && (x_hold < 43))	// down
			begin
				dir[1] = 1'b1;
				dir[0] = 1'b0;
			end
			else 
			begin
				dir[0] = 1'b0;
				dir[1] = 1'b0;
			end
			dir[3] = 1'b0;
			dir[2] = 1'b0;
		end
	
		else if ((211 < y_hold) && (y_hold < 240))	// left
		begin	
			if ((69 < x_hold) && (x_hold < 142))
				dir[2] = 1'b1;
			else	
				dir[2] = 1'b0;
			dir[3] = 1'b0;
			dir[0] = 1'b0;
			dir[1] = 1'b0;
		end
		
		else	
		begin 
			dir = 4'b0;
		end

	end
	
endmodule	