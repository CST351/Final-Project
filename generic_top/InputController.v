module InputController(
			input  wire CLOCK_50,
			input  wire PS2_CLK, PS2_DAT,
			input  wire dataIn,
			output wire touchClk, dataOut,
			output wire [7:0]ascii,
			output wire [3:0]dir
);

	///////////////////////////
	// KeyBoard & Touch
	///////////////////////////
	wire shiftRegEn;
	wire [7:0] keyboardData;
	wire data_en;
	wire [9:0] decodedData;
	wire done;
	wire [3:0] keyDir;
	wire [3:0] touchDir;

	///////////////////////////
	// Touch Screen 
	///////////////////////////
	wire Touch_En, X_Touch, Y_Touch;
	wire [7:0] Data_Wire_Touch;
	wire [7:0] X_Latch, Y_Latch;


	////////////////////////////////////
	//	Keyboard Modules
	////////////////////////////////////
	assign dir[0] = (keyDir[0] | touchDir[0]);
	assign dir[1] = (keyDir[1] | touchDir[1]);
	assign dir[2] = (keyDir[2] | touchDir[2]);
	assign dir[3] = (keyDir[3] | touchDir[3]);
	
	assign ascii = decodedData[7:0];

	//PS2 Data Readin stateMachine
	State_Machine u10 (
		.clk (PS2_CLK),	
		.en (shiftRegEn),
		.done(done)
	);	

	//Holds PS2 data
	Shift_Reg u11 (
		 .en (shiftRegEn),	
		 .data (PS2_DAT),
		 .clk (PS2_CLK),	
		 .data_reg (keyboardData)
	);	
	 
	decoder u12 (
		.PS2_Value (keyboardData),	
		.data_en (data_en),	
		.enable (shiftRegEn),	
		.ASCII (decodedData)
	);	
		
	Key_Controller u13(
		.done(done),
		.ASCII (decodedData),
		.dir (keyDir)
	);
		
	////////////////////////////////////
	//	Touch Modules
	////////////////////////////////////

	//50MHz to 1MHz
	Clock_Div_Touch u20 (	
		.clk (CLOCK_50),		
		.div_clk (touchClk)
	);
		
		
	TFT_Touch_Controller u21 (
		.clk (touchClk),
		.Dout (dataOut),	
		.en (Touch_En),	
		.x (X_Touch),		
		.y (Y_Touch)		
	);
		
	Shift_Reg_Touch u22 (
		.en (Touch_En),	
		.data (dataIn),	
		.clk (touchClk),
		.data_reg (Data_Wire_Touch)
	);	
		
		
	LED_Controller_Touch u23(
		.x_hold (X_Latch),
		.y_hold (Y_Latch),
		.dir(touchDir)
	);
		
	TFT_Touch_Latch u24(
		.x_hold (X_Latch), 
		.y_hold (Y_Latch),
		.data (Data_Wire_Touch),
		.x (X_Touch),
		.y (Y_Touch)
	);
	
endmodule
