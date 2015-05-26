module TFT_Touch_Latch (
	output reg [7:0] x_hold, y_hold, LEDR, LEDG,
	input wire [7:0] data,
	input wire x, y);

always @ (posedge x)	// only when signal is pulsed by state machine
	begin
		LEDR = data;
		x_hold = data;
	end
	
	always @ (posedge y)
	begin		
		LEDG = data;
		y_hold = data;
	end
endmodule
