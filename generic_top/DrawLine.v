module DrawLine(
		input wire move,
		input wire [7:0]x1, x2,
		input wire [8:0]y1, y2,
		input wire [15:0]color,
		output wire done,
		output reg [8:0]dout,
		output reg [18:0]colorCount
);
	reg [8:0] dataCommands [14] = '{ 9'h02A, 					       													//X position 
												9'h02B, 																				//Y position
												9'h02C,			 																	//Color command
												9'h02A, {1'b1,8'h0},  {1'b1,8'h0},  {1'b1,8'h0}, {1'b1,8'hEF}, 	//X position 
												9'h02B, {1'b1,8'h0},  {1'b1,8'h0}, 	{1'b1,8'h01}, {1'b1,8'h3F},		//Y position
												9'h02C};																				//Color command
	//reg  [4:0]count;
	
	wire [15:0]xDiff;
	wire [15:0]yDiff;
	wire [18:0]length;
	wire [7:0]colorHalf;
	reg [4:0]count;
	reg en;
	
	assign xDiff = (x2 - x1) + 1'b1;
	assign yDiff = (y2 - y1) + 1'b1;
	assign length =  ((xDiff) * (yDiff))<<1;
	//assign length = 1856;
	assign colorHalf = (colorCount[0]) ?  color[7:0] : color[15:8];
	assign done = (count == 0);
		
	
	always @ (posedge move)
		if (count != 12 ) begin 
			if (count < 23) begin
				count = count + 1'b1; 
				colorCount = colorCount;
			end
			else begin
				count = 5'b0;
				colorCount = colorCount;
			end
		end
		else begin
			if (colorCount < (length-1'b1)) begin
				count = count;
				colorCount = colorCount + 1'b1;
			end
			else begin
				count = count + 1'b1;
				colorCount = 19'b0;
			end
		end
	
		
	always @ (*)
		case (count)
			0: begin dout = {1'b0,8'h0}; end		// changed from {1'b1, 8'h0}
			1: begin dout = dataCommands[0]; end
			2: begin dout = {1'b1,8'h0};  end 		 
			3: begin dout = {1'b1,x1};  end 		 
			4: begin dout = {1'b1,8'h0};  end 		 
			5: begin dout = {1'b1,x2};  end 		 
			6: begin dout = dataCommands[1];  end  
			7: begin dout = {1'b1,7'b0,y1[8]};  end
			8: begin dout = {1'b1,y1[7:0]};  end 	 
			9: begin dout = {1'b1,7'b0,y2[8]};  end
		  10: begin dout = {1'b1,y2[7:0]};  end 	 
		  11: begin dout = dataCommands[2]; end  
		  12: begin dout = {1'b1,colorHalf};  end
		  13: begin dout = dataCommands[3];  end  
		  14: begin dout = dataCommands[4];  end  
		  15: begin dout = dataCommands[5];  end  
		  16: begin dout = dataCommands[6];  end  
		  17: begin dout = dataCommands[7];  end  
		  18: begin dout = dataCommands[8];  end  
		  19: begin dout = dataCommands[9];  end  
		  20: begin dout = dataCommands[10];  end  
		  21: begin dout = dataCommands[11];  end  
		  22: begin dout = dataCommands[12];  end  
		  23: begin dout = dataCommands[13];  end  
		  default: begin dout = 8'b0;  end
		endcase	
	endmodule
	