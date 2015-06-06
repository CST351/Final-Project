module LCDController(
			input wire clk,
			
			input wire enOverDraw,
			input wire enBattleDraw,
			
			input wire doneLine,
			input wire doneInit,
			
			input wire battleComplete,
			input wire battleStart,
			
			output reg drawCanvas,
			
			output reg inBattle,
			
			output reg enLine,
			output reg enInit,
			
			output reg idle
);

parameter start = 0, initDisp = 1, drawBackground = 2, overHold = 3, overDraw = 4, battleHold = 5, battleDraw = 6;

reg [2:0]state;


always @ (posedge clk)
	begin
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
					state = overHold;
				end
				else begin
					state = drawBackground;
				end
			end
			
			overHold: begin
				if (battleStart)
					state = battleHold;
				else if (enOverDraw) begin
					state = overDraw;
				end
				else begin
					state = overHold;
				end
			end
			
			overDraw: begin 
				if (doneLine) begin
					state = overHold;
				end
				else begin
					state = overDraw;
				end
			end
			
			battleHold: begin
				if (battleComplete)
					state = drawBackground;
				else if (enBattleDraw) begin
					state = battleDraw;
				end
				else begin
					state = battleHold;
				end
			end
			
			battleDraw: begin 
				if (doneLine) begin
					state = battleHold;
				end
				else begin
					state = battleDraw;
				end
			end
			
			default: state = start;
		endcase 
	end
	
always @ (state)
	case (state)
		start: 	 		 begin enLine = 0; enInit = 0; idle = 0; drawCanvas = 0; inBattle = 0; end
		initDisp: 		 begin enLine = 0; enInit = 1; idle = 0; drawCanvas = 0; inBattle = 0; end
		drawBackground: begin enLine = 1; enInit = 0; idle = 0; drawCanvas = 1; inBattle = 0; end
		overHold: 		 begin enLine = 0; enInit = 0; idle = 1; drawCanvas = 0; inBattle = 0; end
		overDraw: 		 begin enLine = 1; enInit = 0; idle = 0; drawCanvas = 0; inBattle = 0; end
		battleHold:		 begin enLine = 0; enInit = 0; idle = 1; drawCanvas = 0; inBattle = 1; end
		battleDraw:		 begin enLine = 1; enInit = 0; idle = 0; drawCanvas = 0; inBattle = 1; end
		default:  		 begin enLine = 0; enInit = 0; idle = 0; drawCanvas = 0; inBattle = 0; end
	endcase
	
endmodule
