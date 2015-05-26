module decoder (
	input wire [7:0] PS2_Value,
	//input wire [10:0] new_line_counter,
	input wire enable,
	output reg data_en, 
	output reg [9:0] ASCII);
	
	always @ (negedge enable)
	begin
		case (PS2_Value)
		8'b00011100: {data_en, ASCII} = 11'b11001100001; // a
		8'b00110010: {data_en, ASCII} = 11'b11001100010; // b
		8'b00100001: {data_en, ASCII} = 11'b11001100011; // c
		8'b00100011: {data_en, ASCII} = 11'b11001100100; // d
		8'b00100100: {data_en, ASCII} = 11'b11001100101; // e
		8'b00101011: {data_en, ASCII} = 11'b11001100110; // f
		8'b00110100: {data_en, ASCII} = 11'b11001100111; // g
		8'b00110011: {data_en, ASCII} = 11'b11001101000; // h
		8'b01000011: {data_en, ASCII} = 11'b11001101001; // i
		8'b00111011: {data_en, ASCII} = 11'b11001101010; // j
		8'b01000010: {data_en, ASCII} = 11'b11001101011; // k
		8'b01001011: {data_en, ASCII} = 11'b11001101100; // l
		8'b00111010: {data_en, ASCII} = 11'b11001101101; // m
		8'b00110001: {data_en, ASCII} = 11'b11001101110; // n
		8'b01000100: {data_en, ASCII} = 11'b11001101111; // o
		8'b01001101: {data_en, ASCII} = 11'b11001110000; // p
		8'b00010101: {data_en, ASCII} = 11'b11001110001; // q
		8'b00101101: {data_en, ASCII} = 11'b11001110010; // r
		8'b00011011: {data_en, ASCII} = 11'b11001110011; // s
		8'b00101100: {data_en, ASCII} = 11'b11001110100; // t
		8'b00111100: {data_en, ASCII} = 11'b11001110101; // u
		8'b00101010: {data_en, ASCII} = 11'b11001110110; // v
		8'b00011101: {data_en, ASCII} = 11'b11001110111; // w
		8'b00100010: {data_en, ASCII} = 11'b11001111000; // x
		8'b00110101: {data_en, ASCII} = 11'b11001111001; // y
		8'b00011010: {data_en, ASCII} = 11'b11001111010; // z
		
		8'b00101001: {data_en, ASCII} = 11'b11000100000; // space
		8'b01011010: {data_en, ASCII} = 11'b10010101000;
		8'b01100110: {data_en, ASCII} = 11'b10000000001; // backspace

		
		8'b00010110: {data_en, ASCII} = 11'b11000100001; // !
		8'b00011110: {data_en, ASCII} = 11'b11001000000; // @
		8'b00100110: {data_en, ASCII} = 11'b11000100011; // #
		8'b00100101: {data_en, ASCII} = 11'b11000100100; // $
		8'b00101110: {data_en, ASCII} = 11'b11000100101; // %
		8'b00110110: {data_en, ASCII} = 11'b11001011110; // ^
		8'b00111101: {data_en, ASCII} = 11'b11000100110; // &
		8'b00111110: {data_en, ASCII} = 11'b11000101010; // *
		8'b01000110: {data_en, ASCII} = 11'b11000101000; // (
		8'b01000101: {data_en, ASCII} = 11'b11000101001; // )
		
		8'b01110000: {data_en, ASCII} = 11'b11000110000; // 0
		8'b01101001: {data_en, ASCII} = 11'b11000110001; // 1
		8'b01110010: {data_en, ASCII} = 11'b01000000101; // arrow down or 2
		8'b01111010: {data_en, ASCII} = 11'b11000110011; // 3
		8'b01101011: {data_en, ASCII} = 11'b01000000110; // arrow left or 4
		8'b01110011: {data_en, ASCII} = 11'b11000110101; // 5
		8'b01110100: {data_en, ASCII} = 11'b01000000111;// arrow right or 6
		8'b01101100: {data_en, ASCII} = 11'b11000110111; // 7
		8'b01110101: {data_en, ASCII} = 11'b01000001000;// arrow up or 8
		8'b01111101: {data_en, ASCII} = 11'b11000111001; // 9
		
		8'b11110000: {data_en, ASCII} = 11'b01100000000; // no enable  0xF0 command
		
		default: {data_en, ASCII} = 11'b00000000000;	// default to all 0's
		endcase
	end
endmodule

		
		