module Overworld(
	input wire clk,
	input wire en,
	input wire [17:0]colorCount,
	input wire [3:0]dir,
	input wire canvas,
	input wire drawHero,
	output reg [7:0]x1, x2,
	output reg [8:0]y1, y2,
	output wire walkSig,
	output wire [15:0]colorOut
);
	
	reg [15:0]color;
	wire [15:0]grassColor;
	wire [15:0]up1Color;
	wire [15:0]up2Color;
	wire [15:0]down1Color;
	wire [15:0]down2Color;
	wire [15:0]right1Color;
	wire [15:0]right2Color;
	wire [15:0]left1Color;
	wire [15:0]left2Color;
	
	
	wire [5:0] spriteWidth [4][2];
	wire [5:0] spriteHeight[4][2];
	

	
	
	reg [23:0] count;
	reg [4:0] animationCount;
	
	reg WalkState;
	reg [1:0]oldDir;
	
	reg [7:0]originX;
	reg [8:0]originY;
	
	wire [7:0]grassOffset;
	
	assign colorOut = (color == 16'hFFFF) ? grassColor : color;

	assign x1 = (canvas|drawHero) ? 8'b0 : originX;
	assign y1 = (canvas|drawHero) ? 9'b0 : originY;
	
	assign grassOffset = (colorCount[7:0] + y1*16 + x1);
	//((x1 + colorCount[3:0]) + ((y1 + colorCount[17:4])*240));
	
	assign walkSig = (animationCount > 15);
	
	//assign x1 = 0;
	//assign y1 = 0;
	
	always @ (posedge WalkState)
		if(en) begin
			if (dir[0]) begin
				if (originX > 0) begin
					originX = originX - 1'b1;
					originY = originY;
				end
				else begin
					originX = originX;
					originY = originY;
				end
			end
			else if (dir[1]) begin
				if (originX < 206) begin
					originX = originX + 1'b1;
					originY = originY;
				end
				else begin
					originX = originX;
					originY = originY;
				end
			end
			else if (dir[2]) begin
				if (originY < 287) begin
					originX = originX;
					originY = originY + 1'b1;
				end
				else begin
					originX = originX;
					originY = originY;
				end
			end
			else if (dir[3]) begin
				if (originY > 0) begin
					originX = originX;
					originY = originY - 1'b1;
				end
				else begin
					originX = originX;
					originY = originY;
				end
			end
			else begin
				originX = originX;
				originY = originY;
			end	
		end	
		else begin
			originX = originX;
			originY = originY;
		end
			
	always @ (posedge clk)
		if (|dir == 0) begin
			WalkState = 0;
			count = 200000;
			animationCount = 2'b00;
		end
		else if (count < 250000) begin
			WalkState = WalkState;
			count = count + 1'b1;
			animationCount = animationCount;
		end
		else begin
			animationCount = animationCount + 1'b1;
			WalkState = 1'b1 ^ WalkState;
			count = 0;
		end
	
	
	always @(negedge clk) begin
		if (~en) begin
			x2 = x2;
			y2 = y2;
		end	
		else if (canvas)
			begin x2 = 239; y2 = 319; end
		else if (drawHero) begin
			begin x2 = spriteWidth[1][0]; y2 = spriteHeight[1][0]; end
		end
		else if (dir[0]) 	begin						//up
			oldDir = 0; 
			if (animationCount[2]) //state 2
				begin x2 = originX + spriteWidth[0][1]; y2 = originY + spriteHeight[0][1]; end
			else				//state 1
				begin x2 = originX + spriteWidth[0][0]; y2 = originY + spriteHeight[0][0]; end	
		end
		else if (dir[1]) 	begin						//down
			oldDir = 1;
			if (animationCount[2]) //state 2
				begin x2 = originX + spriteWidth[1][1]; y2 = originY + spriteHeight[1][1]; end
			else				//state 1
				begin x2 = originX + spriteWidth[1][0]; y2 = originY + spriteHeight[1][0]; end
		end
		else if (dir[2]) begin						//left
			oldDir = 2;
			if (animationCount[2]) //state 2
				begin x2 = originX + spriteWidth[2][1]; y2 = originY + spriteHeight[2][1]; end
			else				//state 1
				begin x2 = originX + spriteWidth[2][0]; y2 = originY + spriteHeight[2][0]; end
		end
		else if (dir[3]) begin						//right
			oldDir = 3;
			if (animationCount[2]) //state 2
				begin x2 = originX + spriteWidth[3][1]; y2 = originY + spriteHeight[3][1]; end
			else				//state 1
				begin x2 = originX + spriteWidth[3][0]; y2 = originY + spriteHeight[3][0]; end
		end
		else	begin										//default
			oldDir = oldDir;
			case (oldDir)
				0: begin x2 = originX + spriteWidth[0][0]; y2 = originY + spriteHeight[0][0]; end
				1: begin x2 = originX + spriteWidth[1][0]; y2 = originY + spriteHeight[1][0]; end
				2: begin x2 = originX + spriteWidth[2][0]; y2 = originY + spriteHeight[2][0]; end
				3: begin x2 = originX + spriteWidth[3][0]; y2 = originY + spriteHeight[3][0]; end
			endcase
		end
	end
		
	always @ (negedge clk)	
		if (~en)
			color = color;
		else if (canvas)
			color = grassColor;
		else if (drawHero)
			color = down1Color;
		else if (dir[0]) 
			if (animationCount[2]) //state 2
				color = up2Color;
			else				//state 1
				color = up1Color;
		else if (dir[1]) 
			if (animationCount[2]) //state 2
				color = down2Color;
			else				//state 1
				color = down1Color;
		else if (dir[2]) 
			if (animationCount[2]) //state 2
				color = left2Color;
			else				//state 1
				color = left1Color;
		else if (dir[3])
			if (animationCount[2]) //state 2
				color = right2Color;
			else				//state 1
				color = right1Color;
		else begin
			case (oldDir)
				0: color = up1Color;
				1: color = down1Color;
				2: color = left1Color;
				3: color = right1Color;
			endcase
		end
			
			

//image modules
	 GrassTile image0 (
		.pixel(grassOffset),	 
		.color(grassColor)
	);

	FFI_Warrior_Overworld_Down1 image1 (
		.pixel(colorCount[17:0]),
		.color(down1Color),
		.width(spriteWidth[1][0]),
		.height(spriteHeight[1][0])
	);
	
	FFI_Warrior_Overworld_Down2 image2 (
		.pixel(colorCount[17:0]),
		.color(down2Color),
		.width(spriteWidth[1][1]),
		.height(spriteHeight[1][1])
	);

	FFI_Warrior_Overworld_Left1 image3 (
		.pixel(colorCount[17:0]),
		.color(left1Color),
		.width(spriteWidth[2][0]),
		.height(spriteHeight[2][0])
	);

	FFI_Warrior_Overworld_Left2 image4 (
		.pixel(colorCount[17:0]),
		.color(left2Color),
		.width(spriteWidth[2][1]),
		.height(spriteHeight[2][1])
	);	

	FFI_Warrior_Overworld_Up1 image5 (
		.pixel(colorCount[17:0]),
		.color(up1Color),
		.width(spriteWidth[0][0]),
		.height(spriteHeight[0][0])
	);	
	
	FFI_Warrior_Overworld_Up2 image6 (
		.pixel(colorCount[17:0]),
		.color(up2Color),
		.width(spriteWidth[0][1]),
		.height(spriteHeight[0][1])
	);		
	
	FFI_Warrior_Overworld_Right1 image7 (
		.pixel(colorCount[17:0]),
		.color(right1Color),
		.width(spriteWidth[3][0]),
		.height(spriteHeight[3][0])
	);

	FFI_Warrior_Overworld_Right2 image8 (
		.pixel(colorCount[17:0]),
		.color(right2Color),
		.width(spriteWidth[3][1]),
		.height(spriteHeight[3][1])
	);
	
endmodule
