module LCDController(
			input wire goInit,
			input wire goLine,
			input wire doneLine,
			input wire doneInit,
			input wire clk,
			output wire enLine,
			output wire enInit,
			output wire idle
);

parameter start = 0, drawLine = 1, initSequence = 2;

reg [1:0]state;


always @ (posedge clk)
	case (state)
		start: begin
			if (goInit) begin
				state = initSequence;
			end
			else if (goLine) begin
				state = drawLine;
			end
			else begin
				state = start;
			end
		end
		drawLine: begin 
			if (doneLine) begin
				state = start;
			end
			else begin
				state = drawLine;
			end
		end
		initSequence: begin 
			if (doneInit) begin
				state = start;
			end
			else begin
				state = initSequence;
			end
		end
		default: state = start;
	endcase 
	
always @ (state)
	case (state)
		start: begin enLine = 0; enInit = 0; idle = 1;end
		drawLine: begin enLine = 1; enInit = 0; idle = 0;end
		initSequence: begin enLine = 0; enInit = 1; idle = 0;end
		default: begin enLine = 0; enInit = 0; idle = 0; end
	endcase

endmodule
