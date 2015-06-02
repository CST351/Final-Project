module Key_Controller (
	input wire done,
	input wire [9:0] ASCII,
	output reg [4:0] LED,
	output reg leftOut, rightOut, upOut, downOut);
	
reg releaseCommand;

always @ (posedge done)
begin
	if (ASCII == 10'b1100000000) begin
		releaseCommand = 1;
		leftOut = leftOut; rightOut = rightOut; upOut = upOut; downOut = downOut; 
	end
	else if (releaseCommand) begin
		case (ASCII)
			10'b1000001000:	upOut = 1'b0;		// up
			10'b1000000101: 	downOut = 1'b0;	//down
			10'b1000000110:	leftOut = 1'b0;	// left
			10'b1000000111: 	rightOut = 1'b0;	// right
			default:	begin leftOut = leftOut; rightOut = rightOut; upOut = upOut; downOut = downOut; end
		endcase
		releaseCommand = 0;
	end
	else begin
		case (ASCII)
			10'b1000001000:	upOut = 1'b1;		// up
			10'b1000000101: 	downOut = 1'b1;	//down
			10'b1000000110:	leftOut = 1'b1;	// left
			10'b1000000111: 	rightOut = 1'b1;	// right
			default:	begin leftOut = leftOut; rightOut = rightOut; upOut = upOut; downOut = downOut; end
		endcase
	end
end
		
	
	
	
		/*if (ASCII == 10'b1100000000)
		begin
			releaseCommand = 1'b1;
			LED = 1'b1;
		end
		else
		begin 
			case (ASCII)
			10'b1000110010:	begin	// down
				if (releaseCommand)
					{leftOut, rightOut, upOut, downOut} = {leftOut, rightOut, upOut, 1'b0};
				else
					{leftOut, rightOut, upOut, downOut} = {leftOut, rightOut, upOut, 1'b1};
				releaseCommand = 1'b0;
			end
			10'b1000110100:	begin // left
				if (releaseCommand)
					{leftOut, rightOut, upOut, downOut} = {1'b0, rightOut, upOut, downOut};
				else
					{leftOut, rightOut, upOut, downOut} = {1'b1, rightOut, upOut, downOut};
				releaseCommand = 1'b0;
			end
			10'b1000110110: 	begin	// right
				if (releaseCommand)
					{leftOut, rightOut, upOut, downOut} = {leftOut, 1'b0, upOut, downOut};
				else
					{leftOut, rightOut, upOut, downOut} = {leftOut, 1'b1, upOut, downOut};
				releaseCommand = 1'b0;
			end
			10'b1000111000: 	begin	// up
				if (releaseCommand)
					{leftOut, rightOut, upOut, downOut} = {leftOut, rightOut, 1'b0, downOut};
				else
					{leftOut, rightOut, upOut, downOut} = {leftOut, rightOut, 1'b1, downOut};
				releaseCommand = 1'b0;
			end
			
			default: begin leftOut = 1'b0; rightOut = 1'b0; upOut = 1'b0; downOut = 1'b0; releaseCommand = 1'b0; end
			//default: begin	{leftOut, rightOut, upOut, downOut} = 4'b0000; releaseCommand = releaseCommand;	end
			endcase
		end*/
	//end
endmodule
