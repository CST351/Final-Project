 module LED_Controller_Touch (
	input  reg [7:0] x_hold, y_hold,
	input wire BattleEn,
	output reg [3:0] dir
);

	always @ (x_hold or y_hold)
	begin
	if (~BattleEn)
	begin
		if ((13 < y_hold) && (y_hold < 50))			// right
		begin
			if ((69 < x_hold) && (x_hold < 142))
				dir[3] = 1'b1;
			else 
				dir[3] = 1'b0;
			dir[2:0] = 1'b0;
		end
		
		else if ((74 < y_hold) && (y_hold < 153))	// up
		begin	
			if ((210 < x_hold) && (x_hold < 240))
			begin
				dir[0] = 1'b1;
				dir[1] = 1'b0;
			end
			else if ((26 < x_hold) && (x_hold < 63))	// down
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
	
		else if ((195 < y_hold) && (y_hold < 240))	// left
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
	else
	begin
		if ((x_hold > 26) && (x_hold < 100))
		begin
			if ((y_hold < 240) && (y_hold > 120))	// left
				dir = 4'b0100;
			else if ((y_hold < 14) && y_hold < 120)
				dir = 4'b1000;		// right
		end
		else
			dir = 4'b0000;		
	end
	end
	
endmodule	