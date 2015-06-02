module Sprite_Controller(
	input wire goLine,		
	input wire doneLine,
	input wire doneInit,
	input wire [17:0]colorCount,
	input wire [3:0]dir,
	input wire clk,
	output reg [7:0]x1, x2,
	output reg [8:0]y1, y2,
	output wire walkSig,
	output wire [15:0]colorOut,
	output wire enLine,
	output wire enInit,
	output wire idle
);

wire drawCanvas;
	
LCDController u1 (
				.goLine((|dir)),
				.doneLine(doneLine),
				.doneInit(doneInit),
				.drawCanvas(drawCanvas),
				.clk(clk),
				.enLine(enLine),
				.enInit(enInit),
				.idle(idle)
);
	
	
Overworld_Control u2(
				.colorCount(colorCount),
				.dir(dir),
				.canvas(drawCanvas),
				.clk(clk),
				.x1(x1), 
				.x2(x2),
				.y1(y1), 
				.y2(y2),
				.walkSig(walkSig),
				.colorOut(colorOut)
);
	
	
endmodule
