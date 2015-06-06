module Battleworld (
	input wire Clock,  					// Generic control clock (50MHz should be work)
	input wire [1:0] Dir,				// directional input
	input wire Done,
	input wire [17:0]ColorCount,		// which color we want to access (2nd bit)
	input wire [19:0] RandomValue,	// value from LFSR
	input wire battleEn,					// can we start the battle scene?
	output reg [15:0] ColorOut,			// 16 bit color value
	output reg [7:0]x1, x2,				// starting location
	output reg [8:0]y1, y2,				// ending location
	output reg DrawEn, 
	output wire RNG_LatchEn,
	output reg battleComplete,
	output wire [4:0] LEDR
);
	
	
	localparam Init = 5'b00000, DrawScene = 5'b00001, DrawHero = 5'b00010, DrawEnemy = 5'b00011, PlayerTurn = 5'b00100, PlayerCalc = 5'b00101, 
				  PlayerHitAnimation = 5'b00110, EnemyDieAnimation = 5'b00111, EnemyTurn = 5'b01000, EnemyCalc = 5'b01001, EnemyHitAnimation = 5'b01010, EndBattle = 5'b11111,
				  PlayerIdle = 5'b01011, EnemyIdle = 5'b01100, DrawHeroText = 5'b01101, ClearHeroText = 5'b01110, DrawEnemyText = 5'b01111, ClearEnemyText = 5'b10000, 
				  wait1 = 5'b10001, wait2 = 5'b10010, wait0 = 5'b10011, wait3 = 5'b10100, wait4 = 5'b10101, wait5 = 5'b10110, wait6 = 5'b10111, wait7 = 5'b11000, wait8 = 5'b11001;
	
	wire hit[2];
	reg action;
	reg [4:0]  State;
	reg [25:0] counter;
	
	reg [1:0] enemyLife, heroLife;
	
	wire [5:0] HeroHeight, HeroWidth;	// arbitrary values
	wire [5:0] HeroHeight2, HeroWidth2;
	wire [5:0] EnemyHeight, EnemyWidth;
	wire [5:0] EnemyHeight2, EnemyWidth2;
	wire [5:0] HitHeight, HitWidth;
	wire [5:0] MissHeight, MissWidth;
	
	wire [15:0] SceneColorOut;	
	wire [15:0] HeroColorOut;		// arbitrary size - change according to images
	wire [15:0] HeroColorOut2;
	wire [15:0] EnemyColorOut;
	wire [15:0] HitColorOut;
	wire [15:0] MissColorOut;
	
	reg [25:0]drawCount;
	
	assign RNG_LatchEn = ((State == PlayerCalc) | (State == EnemyCalc)) ? 1'b1 : 1'b0;	//poll random

	assign hit[0] = (RandomValue < 996146);
	assign hit[1] = (RandomValue < 996146);
	
	assign HitColorOut = 16'h07E0;
	assign MissColorOut = 16'hF100;
	assign SceneColorOut = 16'hFFFF;
	//assign EnemyColorOut2 = EnemyColorOut;
	
	assign EnemyHeight2 = EnemyHeight;
	assign EnemyWidth2 = EnemyWidth;
	
	assign HitHeight = 50;
	assign HitWidth = 50;
	
	assign MissHeight = 50;
	assign MissWidth = 50;
	
	assign battleComplete = (State == EndBattle);
	
	assign LEDR = State;
	
	////////////////////////////////////////////////////////////////////////////
	//////////////////		State machine control				///////////////////
	////////////////////////////////////////////////////////////////////////////
	
	always @ (posedge Clock)
	begin
		case (State)
		Init:	begin
			counter = 0;
			if (battleEn)
				State = wait7;
			else
				State = Init;
		end
		wait7:	begin
		if (counter < 20000000)	// gonna need a new delay value (.5sec)
			begin
				counter = counter + 1'b1;	
				//action = 1'b1;
				State = wait7;
			end
			else  begin
				State = wait0;
				counter = 0;
			end
		end
		wait0:	begin
			if (drawCount < 20000000)
				State = wait0;
			else	
				State = DrawScene;
		end
		
		DrawScene:	begin	// draw the scene starting from (0,0) to (240, 320)
		if (Done)
			State = wait1;
		else	
			State = DrawScene;
		
		
			/*if (drawCount < 2'b11) begin
				drawCount = drawCount + 1'b1;
				State = DrawScene;
			end
			else if (Done) begin
				drawCount = 2'b00;
				State = DrawHero;
			end
			else begin
				drawCount = drawCount;
				State = DrawScene;
			end*/
		end
		
		wait1:	begin
			if (drawCount < 15000000)
				State = wait1;
			else	
				State = DrawHero;
		end
		
		DrawHero:	begin	// draw hero
		if (Done)
			State = wait2;
		else
			State = DrawHero;
			
			/*if (drawCount < 2'b11) begin
				drawCount = drawCount + 1'b1;
				State = DrawHero;
			end
			else if (Done) begin
				drawCount = 2'b00;
				State = DrawHero;
			end
			else begin
				drawCount = drawCount;
				State = DrawHero;
			end*/
		end
		
		wait2:	begin
		if (drawCount < 9000000)
				State = wait2;
			else	
				State = DrawEnemy;
		end
		
		DrawEnemy:	begin	// draw enemy
		if (Done)
			State = PlayerTurn;
		else
			State = DrawEnemy;
		
			/*if (drawCount < 2'b11) begin
				drawCount = drawCount + 1'b1;
				State = DrawEnemy;
			end
			else if (Done) begin
				drawCount = 2'b00;
				State = DrawEnemy;
			end
			else begin
				drawCount = drawCount;
				State = DrawEnemy;
			end*/
		end
		PlayerTurn:	begin
			if (Dir == 2'b00)	// no directional input yet
				State = PlayerTurn;
			else if (Dir[1])	// run
				State = wait6;
			else 
				State = PlayerCalc;
		end
		PlayerCalc:	begin
			//if (hit)
				State = PlayerHitAnimation;	// sucessfull hit		always goes to hit animation (miss and hit decided later)
			//else	
			//	State = PlayerMissAnimation;	// miss
		end
		PlayerHitAnimation:	begin
			if (counter < 9000000)	// gonna need a new delay value (.5sec)
			begin
				counter = counter + 1'b1;	
				//action = 1'b1;
				State = PlayerHitAnimation;
			end
			else if (Done) begin
				State = wait3;
				counter = 0;
			end
			else
				State = PlayerHitAnimation;
		end
		wait3: begin
			if (counter < 9000000) begin
				counter = counter + 1'b1;
				State = wait3;
			end
			else begin
				counter = 0;
				State = PlayerIdle;
			end
		end
		PlayerIdle:	begin
			if (!Done)
				State = PlayerIdle;
			else 
				State = DrawHeroText;
		end
		
		DrawHeroText:	begin
			if (counter < 9000000)	// gonna need new counter value (1sec) - Keep text up for 1 sec
			begin		
				State = DrawHeroText;
				counter = counter + 1'b1;
			end
			else if (Done)
			begin
				counter = 0;
				State = wait4;
			end
			else
				State = DrawHeroText; // just ending the battle for now
		end

		wait4: begin
			if (counter < 9000000) begin
				counter = counter + 1'b1;
				State = wait4;
			end
			else begin
				counter = 0;
				State = ClearHeroText;
			end
		end
		ClearHeroText:	begin
			if (!Done)
				State = ClearHeroText;
			else	
			begin
				if (enemyLife <= 0)
					State = wait6;
				else
					State = EnemyTurn;
			end
		end
		
		EnemyTurn:	begin
			State = EnemyCalc;
		end
		EnemyCalc:	begin
			//if (hit)
				State = EnemyHitAnimation;	// sucessfull hit		always goes to hit animation (miss and hit decided later)
			//else	
			//	State = PlayerMissAnimation;	// miss
		end
		EnemyHitAnimation:	begin
			if (counter < 9000000)	// gonna need a new delay value (.5sec)
			begin
				counter = counter + 1'b1;	
				//action = 1'b1;
				State = EnemyHitAnimation;
			end
			else if (Done)
			begin
				State = EnemyIdle;
				counter = 0;
			end
			else
				State = EnemyHitAnimation;
		end
		EnemyIdle:	begin
				State = DrawEnemyText;
		end
		
		DrawEnemyText:	begin
			if (counter < 9000000)	// gonna need new counter value (1sec) - Keep text up for 1 sec
			begin		
				State = DrawEnemyText;
				counter = counter + 1'b1;
			end
			else if (Done)
			begin
				counter = 0;
				State = wait8;
			end
			else
				State = DrawEnemyText; // just ending the battle for now
		end
		wait8: begin
		if (counter < 9000000)	// gonna need new counter value (1sec) - Keep text up for 1 sec
			begin		
				State = wait8;
				counter = counter + 1'b1;
			end
			else if (Done)
			begin
				counter = 0;
				State = wait5;
			end
			else
				State = wait8; // just ending the battle for now
		end
		
		wait5: begin
			if (counter < 9000000) begin
				counter = counter + 1'b1;
				State = wait5;
			end
			else begin
				counter = 0;
				State = ClearEnemyText;
			end
		end
		
		ClearEnemyText:	begin
			if (!Done)
				State = ClearEnemyText;
			else	
			begin
				if (heroLife <= 0)
					State = wait6;
				else
					State = PlayerTurn;
			end
		end
		wait6: begin
			if (counter < 9000000) begin
				counter = counter + 1'b1;
				State = wait6;
			end
			else begin
				counter = 0;
				State = EndBattle;
			end
		end
		
		EndBattle:	begin
			State = Init;
			counter = 0;
		end	
		default: State = Init; 
		endcase
	end
	
	////////////////////////////////////////////////////////////////////////////
	//////////////////		State machine Outputs				///////////////////
	////////////////////////////////////////////////////////////////////////////
	
	always @ (negedge Clock)
	begin
		case (State)
		Init:			begin	
			drawCount = 0;
			enemyLife = 2;
			heroLife = 2;		// just set these for now
			DrawEn = 1'b0;
			
			x1 = 8'd0;
			x2 = 8'd0;
			y1 = 9'd0;
			y2 = 9'd0;
		end
		wait7:	begin
			drawCount = 0;
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b0;
			
			x1 = 8'd0;
			x2 = 8'd239;	// set location outputs
			y1 = 9'd0;
			y2 = 9'd319;
		end
		wait0:	begin	
			drawCount = drawCount + 1'b1;
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b1;
			
			x1 = 8'd0;
			x2 = 8'd239;	// set location outputs
			y1 = 9'd0;
			y2 = 9'd319;
		end
		
		DrawScene:	begin
			drawCount = 0;
			enemyLife = enemyLife;	
			heroLife = heroLife;
			DrawEn = 1'b0;
			
			x1 = 8'd0;
			x2 = 8'd239;	// set location outputs
			y1 = 9'd0;
			y2 = 9'd319;
		end
		
		wait1:	begin	
			drawCount = drawCount + 1'b1;
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b1;
			
			x1 = 8'd100;
			x2 = HeroWidth + 8'd100;	// arbitrary values
			y1 = 9'd75;
			y2 = HeroHeight + 9'd75;
		end
		
		DrawHero:	begin
			drawCount = 0;
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b0;
			
			x1 = 8'd100;
			x2 = HeroWidth + 8'd100;	// arbitrary values
			y1 = 9'd75;
			y2 = HeroHeight + 9'd75;
		end
		
		wait2:	begin	
			drawCount = drawCount + 1'b1;
			enemyLife = enemyLife;
			heroLife = heroLife;
			
			DrawEn = 1'b1;
			x1 = 8'd100;
			x2 = EnemyWidth + 8'd100;	// arbitrary values
			y1 = 9'd225;
			y2 = EnemyHeight + 9'd225;
		end
		
		DrawEnemy:	begin
			drawCount = 0;
			enemyLife = enemyLife;
			heroLife = heroLife;
			
			DrawEn = 1'b0;
			x1 = 8'd100;
			x2 = EnemyWidth + 8'd100;	// arbitrary values
			y1 = 9'd225;
			y2 = EnemyHeight + 9'd225;
		end
		PlayerTurn:	begin		// not drawing anything
			enemyLife = enemyLife;
			heroLife = heroLife;
			
			DrawEn = 1'b0;
			x1 = 8'd0;	
			x2 = 8'd0;
			y1 = 9'd0;
			y2 = 9'd0;		
		end
		PlayerCalc:	begin
			heroLife = heroLife;
			
			DrawEn = 1'b0;
			x1 = 8'd0;	
			x2 = 8'd0;
			y1 = 9'd0;
			y2 = 9'd0;		
			if (hit[0])	//90% chance to hit
				enemyLife = enemyLife - 1'b1;
			else
				enemyLife = enemyLife;
		end
		PlayerHitAnimation: begin	// bring sword up
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b1;
			
			x1 = 8'd100;
			x2 = HeroWidth2 + 8'd100;	// same location as original hero drawn
			y1 = 9'd75;
			y2 = HeroHeight2 + 9'd75;
		end
		wait3:	begin	
			drawCount = drawCount + 1'b1;
			enemyLife = enemyLife;
			heroLife = heroLife;
			
			DrawEn = 1'b1;
				
			x1 = 8'd100;
			x2 = HeroWidth + 8'd100;	// same location as original hero drawn
			y1 = 9'd75;
			y2 = HeroHeight + 9'd75;
		end
		PlayerIdle:	begin				// lower sword
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b0;
			
			x1 = 8'd100;
			x2 = HeroWidth + 8'd100;	// same location as original hero drawn
			y1 = 9'd75;
			y2 = HeroHeight + 9'd75;
		end
		DrawHeroText:	begin
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b1;
			
			if (hit)
			begin
				x1 = 8'd50;
				x2 = HitWidth + 8'd50;	// "hit" over enemies head
				y1 = 9'd200;
				y2 = HitHeight + 9'd200;				// rough estimates - consult diagram?
			end
			else
			begin
				x1 = 8'd50;
				x2 = MissWidth + 8'd50;	// "miss" over enemies head
				y1 = 9'd200;
				y2 = MissHeight + 9'd200;
			end
		end
		wait4: begin
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b1;
						
			x1 = 8'd50;
			x2 = HitWidth + 8'd50;	// "hit" over enemies head
			y1 = 9'd200;
			y2 = HitHeight + 9'd200;
		end
		ClearHeroText:	begin
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b0;
						
			x1 = 8'd50;
			x2 = HitWidth + 8'd50;	// "hit" over enemies head
			y1 = 9'd200;
			y2 = HitHeight + 9'd200;
		end
		
		EnemyTurn:	begin		// not drawing anything
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b0;
			
			x1 = 8'd0;	
			x2 = 8'd0;
			y1 = 9'd0;
			y2 = 9'd0;		
		end
		EnemyCalc:	begin
			enemyLife = enemyLife;
			DrawEn = 1'b0;
			
			x1 = 8'd0;	
			x2 = 8'd0;
			y1 = 9'd0;
			y2 = 9'd0;		
			if (hit[1])	//90% chance to hit
				heroLife = heroLife - 1'b1;
			else
				heroLife = heroLife;
		end
		EnemyHitAnimation: begin	// bring sword up
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b0;
			
			x1 = 8'd100;
			x2 = EnemyWidth2 + 8'd100;	// same location as original hero drawn					// must adjust these to the enemies locations
			y1 = 9'd225;
			y2 = EnemyHeight2 + 9'd225;
		end
		EnemyIdle:	begin				// lower sword
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b0;
			
			x1 = 8'd100;
			x2 = EnemyWidth + 8'd100;	// same location as original hero drawn
			y1 = 9'd225;
			y2 = EnemyHeight + 9'd225;
		end
		DrawEnemyText:	begin
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b1;
			
			if (hit[1])
			begin
				x1 = 8'd50;
				x2 = HitWidth + 8'd50;	// "hit" over enemies head
				y1 = 9'd50;
				y2 = HitHeight + 9'd50;
			end
			else
			begin
				x1 = 8'd50;
				x2 = MissWidth + 8'd50;	// "miss" over enemies head
				y1 = 9'd50;
				y2 = MissHeight + 9'd50;
			end
		end
		wait8: begin
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b0;
						
			x1 = 8'd50;
			x2 = HitWidth + 8'd50;	
			y1 = 9'd50;
			y2 = HitHeight + 9'd50; 
		end
		wait5: begin
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b1;
						
			x1 = 8'd50;
			x2 = HitWidth + 8'd50;	
			y1 = 9'd50;
			y2 = HitHeight + 9'd50; 
		end
		ClearEnemyText:	begin
			DrawEn = 1'b0;
			
			enemyLife = enemyLife;
			heroLife = heroLife;
			
			x1 = 8'd50;
			x2 = HitWidth + 8'd50;	
			y1 = 9'd50;
			y2 = HitHeight + 9'd50; 
		end
		wait6: begin
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b0;
			
			x1 = x1;	// start at origin
			x2 = x2;
			y1 = y1;
			y2 = y2;
		end
		EndBattle: begin
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b0;
			
			x1 = x1;	// start at origin
			x2 = x2;
			y1 = y1;
			y2 = y2;
		end
		default:	begin	
			enemyLife = enemyLife;
			heroLife = heroLife;
			DrawEn = 1'b0;
			
			x1 = x1;	// start at origin
			x2 = x2;
			y1 = y1;
			y2 = y2;
		end
		endcase
	end
	
	////////////////////////////////////////////////////////////////////////////
	//////////////////		Module that grabs drawing data	///////////////////
	////////////////////////////////////////////////////////////////////////////
	always @ (negedge Clock)
	begin
		case (State)
			Init:						ColorOut = SceneColorOut;
			wait7:					ColorOut = SceneColorOut;
			wait0: 					ColorOut = SceneColorOut;	
			DrawScene:				ColorOut = SceneColorOut;	
			wait1: 					ColorOut = HeroColorOut;	
			DrawHero:				ColorOut = HeroColorOut;
			wait2: 					ColorOut = EnemyColorOut;
			DrawEnemy:				ColorOut = EnemyColorOut;
			PlayerHitAnimation:	ColorOut = HeroColorOut2;
			wait3:					ColorOut = HeroColorOut;
			PlayerIdle:				ColorOut = HeroColorOut;
			DrawHeroText:	begin
					if (hit)
						ColorOut = HitColorOut;
					else
						ColorOut = MissColorOut;
			end
			wait4: ColorOut = 16'hFFFF;	
			ClearHeroText:	ColorOut = 16'hFFFF;				
			DrawEnemyText:	begin
					if (hit)
						ColorOut = HitColorOut;
					else
						ColorOut = MissColorOut;
			end
			wait8: ColorOut = 16'hFFFF;
			wait5: ColorOut = 16'hFFFF;	
			ClearEnemyText: ColorOut = 16'hFFFF;
			default:	ColorOut = ColorOut;	
		endcase
	end
	
	
	/////////////////////////////// 
	// 	Picture Files Here
	///////////////////////////////
	FFI_Warrior_Battle_Idle image1 (
		.pixel(ColorCount[17:0]),
		.color(HeroColorOut),
		.width(HeroWidth),
		.height(HeroHeight)
	);

	 FFI_Warrior_Battle_Attack2 image3 (
		.pixel(ColorCount[17:0]),
		.color(HeroColorOut2),
		.width(HeroWidth2),
		.height(HeroHeight2)
	);

	charizard image4 (
		.pixel(ColorCount[17:0]),
		.color(EnemyColorOut),
		.width(EnemyWidth),
		.height(EnemyHeight)
	);

	
endmodule
