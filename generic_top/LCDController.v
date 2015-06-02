module LCDController(
			input wire goLine,
			input wire doneLine,
			input wire doneInit,
			input wire clk,
			output reg drawCanvas,
			output reg enLine,
			output reg enInit,
			output reg idle
);

parameter start = 0, initDisp = 1, drawBackground = 2, wait1 = 3, drawHold = 4, drawLine = 5;

reg [2:0]state;


always @ (posedge clk)
	case (state)
		start: begin
			state = initDisp;
		end
		initDisp: begin 
			if (doneInit) begin
				state = drawBackground;
			end
			else begin
				state = initDisp;
			end
		end
		drawBackground: begin 
			if (doneLine) begin
				state = wait1;
			end
			else begin
				state = drawBackground;
			end
		end
		wait1: begin
			if (doneLine)
				state = drawLine;
			else
				state = wait1;
		end
		drawHold: begin
		   if (goLine) begin
				state = drawLine;
			end
			else begin
				state = drawHold;
			end
		end
		drawLine: begin 
			if (doneLine) begin
				state = drawHold;
			end
			else begin
				state = drawLine;
			end
		end
		default: state = drawHold;
	endcase 
	
always @ (state)
	case (state)
		start: 	 		 begin enLine = 0; enInit = 0; idle = 0; drawCanvas = 0;end
		initDisp: 		 begin enLine = 0; enInit = 1; idle = 0; drawCanvas = 0;end
		drawBackground: begin enLine = 1; enInit = 0; idle = 0; drawCanvas = 1;end
		wait1: 	 		 begin enLine = 0; enInit = 0; idle = 1; drawCanvas = 0;end
		drawHold: 		 begin enLine = 0; enInit = 0; idle = 1; drawCanvas = 0;end
		drawLine: 		 begin enLine = 1; enInit = 0; idle = 0; drawCanvas = 0;end
		default:  		 begin enLine = 0; enInit = 0; idle = 0; drawCanvas = 0;end
	endcase
	
endmodule
