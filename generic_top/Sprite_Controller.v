module Sprite_Controller(		
	input wire clk,
		
	input wire doneLine,
	input wire doneInit,
	input wire [17:0]colorCount,
	input wire [3:0]dir,

	input wire [19:0]RNG,
	output reg [7:0]x1, x2,
	output reg [8:0]y1, y2,
	output wire [15:0]colorOut,
	
	output wire enLine,
	output wire enInit,
	output wire idle,
	
	output wire enterBattle
	
	//output wire [10:0] GPIO
);

wire drawCanvas;

wire battle_enLine;
wire battleComplete;

wire [7:0]rx1[2], rx2[2]; 
wire [8:0]ry1[2], ry2[2];
wire [15:0] rcolorOut [2];
wire pollRand;
//wire enterBattle;

wire [19:0]RNGOver;
wire [19:0]RNGBattle;

wire walkSig;

//reg battleEn;

wire inBattle;

assign x1 = (inBattle) ? rx1 [1] : rx1[0];
assign x2 = (inBattle) ? rx2 [1] : rx2[0];
assign y1 = (inBattle) ? ry1 [1] : ry1[0];
assign y2 = (inBattle) ? ry2 [1] : ry2[0];
assign colorOut = (inBattle) ? rcolorOut [1] : rcolorOut [0];


//assign enterBattle = (RNGOver > 996146)? 1'b0 : 1'b1; //10% chance

always @ (posedge walkSig or posedge battleComplete)
	if (battleComplete)
		enterBattle = 0;
	else
		enterBattle = (RNGOver > 996146)? 1'b0 : 1'b1;

LCDController u1 (
				.clk(clk),
				
				.enOverDraw(|dir),
				.enBattleDraw(battle_enLine),
				
				.doneLine(doneLine),
				.doneInit(doneInit),
				
				.battleComplete(battleComplete),
				.battleStart(enterBattle),
				
				.drawCanvas(drawCanvas),
				.inBattle(inBattle),
				
				.enLine(enLine),
				.enInit(enInit),
				.idle(idle)
				
				
);
	
	
Overworld u2(
				.clk(clk),
				.en(~inBattle),
				.colorCount(colorCount),
				.dir(dir),
				
				.canvas(drawCanvas),
				
				.x1(rx1[0]), 
				.x2(rx2[0]),
				.y1(ry1[0]), 
				.y2(ry2[0]),
				.walkSig(walkSig),
				.colorOut(rcolorOut[0])
);
	
	
Battleworld u3 (
	.Clock (clk),  					// Generic control clock (50MHz should be work)
	.Dir (dir[3:2]),				// directional input
	.Done(doneLine),
	.ColorCount (colorCount),		// which color we want to access (2nd bit)
	.RandomValue (RNGBattle),	// value from LFSR
	.battleEn (inBattle),					// can we start the battle scene?
	.ColorOut (rcolorOut[1]),			// 16 bit color value
	.x1 (rx1[1]), 
	.x2 (rx2[1]),				// starting location
	.y1 (ry1[1]), 
	.y2 (ry2[1]),				// ending location
	.DrawEn (battle_enLine), 
	.RNG_LatchEn (pollRand),
	.battleComplete (battleComplete)
);

pollREG u4 (
			.en(walkSig & ~inBattle),
			.dataIn(RNG),
			.dataOut(RNGOver)
);
pollREG u5 (
			.en(pollRand),
			.dataIn(RNG),
			.dataOut(RNGBattle)
);
	
endmodule
