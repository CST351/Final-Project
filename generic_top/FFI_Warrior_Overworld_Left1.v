//---Example Use---
// FFI_Warrior_Overworld_Left1 image1 (
//	.pixel(),
//	.color(),
//	.width(),
//	.height()
//);

module FFI_Warrior_Overworld_Left1 (
	input wire [16:0] pixel,
	output wire [5:0]width, height,
	output reg [15:0] color
);

	reg [15:0] image [1019:0] = '{
		16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'h5a4, 16'h2082, 16'hffff, 16'hffff, 16'h2082, 16'h7283, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'h7283, 16'h5a4, 16'h2082, 16'hffff, 16'h2082, 16'hb3c6, 16'h5a4, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'h8b2, 16'hb3c6, 16'h8b2, 16'h5a4, 16'h2082, 16'hb3c6, 16'hed8d, 16'h7283, 16'h8b2, 16'h2082, 16'hffff, 16'hffff, 16'h2082, 16'h2082, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'h5a4, 16'hb3c6, 16'hdc8b, 16'hb3c6, 16'h8b2, 16'h7283, 16'hdc8b, 16'hed8d, 16'h8b2, 16'hdc8b, 16'h7283, 16'h2082, 16'h2082, 16'h700, 16'hc659, 16'h2082, 16'h2082, 16'h2082, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'h8b2, 16'hdc8b, 16'hed8d, 16'hb3c6, 16'hdc8b, 16'h8b2, 16'hed8d, 16'hdc8b, 16'hb3c6, 16'hed8d, 16'h8b2, 16'h2082, 16'h700, 16'h982, 16'hc659, 16'h2082, 16'ha2c5, 16'hd386, 16'ha2c5, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'h2082, 16'hffff, 16'h2082, 16'h5a4, 16'hb3c6, 16'hed8d, 16'hed8d, 16'hdc8b, 16'hdc8b, 16'hb3c6, 16'hdc8b, 16'h7283, 16'hdc8b, 16'hdc8b, 16'hb3c6, 16'h2082, 16'h982, 16'hd946, 16'hf79e, 16'h2082, 16'hd386, 16'hf692, 16'he5c, 16'hb84, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'h2082, 16'h2082, 16'h2082, 16'h7283, 16'hed8d, 16'hfe90, 16'hed8d, 16'hed8d, 16'hdc8b, 16'hb3c6, 16'h7283, 16'h8b2, 16'h7283, 16'hb3c6, 16'hb3c6, 16'h2082, 16'hb84, 16'hd946, 16'h982, 16'hf79e, 16'h2082, 16'hf692, 16'hd946, 16'he5c, 16'he5c, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'h2082, 16'h8b2, 16'h7283, 16'hb3c6, 16'hfe90, 16'hfe90, 16'hfe90, 16'hed8d, 16'hb3c6, 16'h7283, 16'h7283, 16'hb3c6, 16'h7283, 16'h5a4, 16'h8b2, 16'h2082, 16'hb84, 16'hd946, 16'hd946, 16'hf79e, 16'h2082, 16'hb84, 16'hf692, 16'hf692, 16'hf692, 16'he5c, 16'h2082, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'h2082, 16'hb3c6, 16'h8b2, 16'hdc8b, 16'hfe90, 16'hfe90, 16'hfe90, 16'hdc8b, 16'h8b2, 16'h7283, 16'hdc8b, 16'hb3c6, 16'h8b2, 16'h5a4, 16'h7283, 16'h2082, 16'h982, 16'hfa89, 16'hf79e, 16'hf79e, 16'h2082, 16'h982, 16'hf692, 16'hf692, 16'hf692, 16'hf692, 16'h2082, 16'h9d15, 16'h2082, 16'h2082, 16'h2082, 16'h2082, 16'hffff, 
		16'hffff, 16'h2082, 16'hdc8b, 16'hdc8b, 16'hdc8b, 16'hfe90, 16'hfe90, 16'hed8d, 16'hb3c6, 16'h8b2, 16'hed8d, 16'hdc8b, 16'h8b2, 16'hed8d, 16'h5a4, 16'h2082, 16'h725, 16'h2082, 16'hb84, 16'hfa89, 16'hb84, 16'hf79e, 16'h700, 16'hf692, 16'hf692, 16'hf692, 16'hf692, 16'h2082, 16'h9d15, 16'h2082, 16'h700, 16'hfc9, 16'hd347, 16'hffff, 
		16'hffff, 16'h2082, 16'hdc8b, 16'hed8d, 16'hdc8b, 16'hfe90, 16'hfe90, 16'hdc8b, 16'h8b2, 16'hed8d, 16'hed8d, 16'hb3c6, 16'hfe90, 16'hb3c6, 16'h2082, 16'hd386, 16'hd386, 16'h725, 16'h2082, 16'hb84, 16'hb84, 16'hf79e, 16'h2082, 16'he5c, 16'hf692, 16'hf692, 16'h2082, 16'h9d15, 16'h2082, 16'hd347, 16'h700, 16'hd946, 16'hd347, 16'hffff, 
		16'hffff, 16'h2082, 16'hdc8b, 16'hfe90, 16'hed8d, 16'hfe90, 16'hed8d, 16'hb3c6, 16'hfe90, 16'hed8d, 16'hb3c6, 16'hfe90, 16'hed8d, 16'h5a4, 16'h2082, 16'ha2c5, 16'hd386, 16'h725, 16'hc659, 16'h2082, 16'h2082, 16'h982, 16'hb84, 16'h2082, 16'he5c, 16'h2082, 16'h2082, 16'h2082, 16'h738f, 16'hfc9, 16'h982, 16'hd946, 16'h700, 16'hffff, 
		16'hffff, 16'h2082, 16'hb3c6, 16'hfe90, 16'hfe90, 16'hed8d, 16'hdc8b, 16'hfe90, 16'hfe90, 16'hed8d, 16'hfe90, 16'hfe90, 16'h8b2, 16'h2082, 16'hc659, 16'hc659, 16'h9d15, 16'hd386, 16'h725, 16'hc659, 16'h700, 16'hb84, 16'hd946, 16'h700, 16'h2082, 16'h8c93, 16'hc659, 16'hc659, 16'h738f, 16'hfc9, 16'h982, 16'hd946, 16'hfc9, 16'hffff, 
		16'hffff, 16'h2082, 16'h7283, 16'hed8d, 16'hfe90, 16'hb3c6, 16'hed8d, 16'hfe90, 16'hfe90, 16'hfe90, 16'hfe90, 16'h8b2, 16'h2082, 16'hc659, 16'hf79e, 16'hf79e, 16'hc659, 16'he5c, 16'hd386, 16'h2082, 16'hc659, 16'h982, 16'hfa89, 16'h700, 16'hdc8b, 16'h2082, 16'h2082, 16'h2082, 16'h738f, 16'hfc9, 16'h982, 16'hd347, 16'hfc9, 16'hffff, 
		16'hffff, 16'hffff, 16'h2082, 16'hb3c6, 16'hed8d, 16'hb3c6, 16'hfe90, 16'hfe90, 16'hfe90, 16'hdc8b, 16'h8b2, 16'h5a4, 16'h2082, 16'h2082, 16'h2082, 16'h2082, 16'h725, 16'hf692, 16'he5c, 16'h2082, 16'hf79e, 16'h700, 16'hfa89, 16'h700, 16'h8b2, 16'hd946, 16'hf79e, 16'hf79e, 16'h2082, 16'h2082, 16'h2082, 16'haa86, 16'hfc9, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'hdc8b, 16'h8b2, 16'hfe90, 16'hfe90, 16'hdc8b, 16'h5a4, 16'h5a4, 16'ha2c5, 16'h725, 16'h2082, 16'h2082, 16'h725, 16'ha2c5, 16'hf692, 16'hf692, 16'h2082, 16'hf79e, 16'h700, 16'hfa89, 16'h700, 16'hf79e, 16'hd946, 16'hd946, 16'hd946, 16'hf79e, 16'h2082, 16'hffff, 16'h2082, 16'haa86, 16'hffff, 
		16'hffff, 16'hffff, 16'h2082, 16'h2082, 16'h7283, 16'h8b2, 16'hed8d, 16'hfe90, 16'h8b2, 16'h5a4, 16'ha2c5, 16'hd386, 16'he5c, 16'he5c, 16'hf692, 16'hf692, 16'hf692, 16'hf692, 16'he5c, 16'h2082, 16'h2082, 16'hb84, 16'hb84, 16'h700, 16'h2082, 16'h2082, 16'h2082, 16'h2082, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'hffff, 
		16'hffff, 16'h2082, 16'hed8d, 16'hdc8b, 16'h8b2, 16'h7283, 16'hb3c6, 16'hed8d, 16'hb3c6, 16'hdc8b, 16'h5a4, 16'hd386, 16'he5c, 16'he5c, 16'he5c, 16'he5c, 16'he5c, 16'hd386, 16'ha2c5, 16'h2082, 16'hffff, 16'h2082, 16'h2082, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'h2082, 16'hed8d, 16'hfe90, 16'hed8d, 16'h7283, 16'hdc8b, 16'hdc8b, 16'h8b2, 16'h5a4, 16'hd386, 16'hd386, 16'ha2c5, 16'ha2c5, 16'h725, 16'h725, 16'h2082, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'hdc8b, 16'hfe90, 16'hed8d, 16'h7283, 16'h7283, 16'h5a4, 16'h2082, 16'h2082, 16'h2082, 16'h2082, 16'h2082, 16'h2082, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'h5a4, 16'h8b2, 16'h8b2, 16'h5a4, 16'hed8d, 16'hed8d, 16'hb3c6, 16'h8b2, 16'h7283, 16'h7283, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'h5a4, 16'hb3c6, 16'hb3c6, 16'h8b2, 16'h5a4, 16'h5a4, 16'hed8d, 16'hed8d, 16'hdc8b, 16'h8b2, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'h2082, 16'h7283, 16'hb3c6, 16'hb3c6, 16'h8b2, 16'h5a4, 16'hb3c6, 16'h5a4, 16'h2082, 16'h2082, 16'h2082, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'h2082, 16'h2082, 16'h2082, 16'h2082, 16'hb3c6, 16'h5a4, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'h7283, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'h2082, 16'h2082, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 
		16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff, 16'hffff
};

	assign width  = 29;
	assign height = 33;

	assign color  = image[pixel];

endmodule
