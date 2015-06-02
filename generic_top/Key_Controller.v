module Key_Controller (
	input wire done,
	input wire [9:0] ASCII,
	output reg [3:0] dir
);
		
	reg releaseCommand;

	always @ (posedge done)
	begin
		if (ASCII == 10'b1100000000) begin
			releaseCommand = 1;
			dir = dir;
		end
		else if (releaseCommand) begin
			case (ASCII)
				10'b1000001000:	dir[0] = 1'b0;	// up
				10'b1000000101: 	dir[1] = 1'b0;	// down
				10'b1000000110:	dir[2] = 1'b0;	// left
				10'b1000000111: 	dir[3] = 1'b0;	// right
				default: dir = dir; 
			endcase
			releaseCommand = 0;
		end
		else begin
			case (ASCII)
				10'b1000001000:	dir[0] = 1'b1;	// up
				10'b1000000101: 	dir[1] = 1'b1;	// down
				10'b1000000110:	dir[2] = 1'b1;	// left
				10'b1000000111: 	dir[3] = 1'b1;	// right
				default:	dir = dir;
			endcase
		end
	end
		
endmodule
