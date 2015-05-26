module init (
	input wire move,
	output wire done, 
	output reg dc, resetOut, clkHold, dataHold, 
	output reg [7:0] dOut
);
	
	reg [8:0] ra [47:0];
	reg [5:0] count;
	reg [22:0] rstCounter;
 
	initial begin
										//delay
		ra[0] = 9'b011001011;	// cb
		ra[1] = 9'b100111001;	// 39
		ra[2] = 9'b100101100;	// 2c
		ra[3] = 9'b100000000;	// 00
		ra[4] = 9'b100110100;	// 34
		ra[5] = 9'b100000010;	// 02
		ra[6] = 9'b011001111;	// cf
		ra[7] = 9'b100000000;	// 00
		ra[8] = 9'b111000001;	// c1
		ra[9] = 9'b100110000;	// 30
		ra[10] = 9'b011101000;	// e8
		ra[11] = 9'b110000101;	// 85
		ra[12] = 9'b100000000;	// 00
		ra[13] = 9'b101111000;	// 78
		ra[14] = 9'b011101010;	// ea
		ra[15] = 9'b100000000;	// 00
		ra[16] = 9'b100000000;	// 00
		ra[17] = 9'b011101101;	// ed
		ra[18] = 9'b101100100;	// 64
		ra[19] = 9'b100000011;	// 03
		ra[20] = 9'b100010010;	// 12
		ra[21] = 9'b110000001;	// 81
		ra[22] = 9'b011110111;	// f7
		ra[23] = 9'b100100000;	// 20
		ra[24] = 9'b011000000;	// c0
		ra[25] = 9'b100100011;	// 23
		ra[26] = 9'b011000001;	// c1
		ra[27] = 9'b100010000;	// 10
		ra[28] = 9'b011000101;	// c5
		ra[29] = 9'b100111110;	// 3e
		ra[30] = 9'b100101000;	// 28
		ra[31] = 9'b011000111;	// c7
		ra[32] = 9'b110000110;	// 86
		ra[33] = 9'b000110110;	// 36
		ra[34] = 9'b101001000;	// 48
		ra[35] = 9'b000111010;	// 3a
		ra[36] = 9'b101010101;	// 55
		ra[37] = 9'b010110001;	// b1
		ra[38] = 9'b100000000;	// 00
		ra[39] = 9'b100011000;	// 18
		ra[40] = 9'b010110110;	// b6
		ra[41] = 9'b100001000;	// 08
		ra[42] = 9'b110000010;	// 82
		ra[43] = 9'b100100111;	// 27
		ra[44] = 9'b000010001;	// 11							
		ra[45] = 9'b000101001;	// 29
		ra[46] = 9'b000101100;	// 2c
		ra[47] = 9'b000000000; // nothing
	end
	
	assign done = (count == 0 && rstCounter == 0);
	
	always @ (posedge move) begin
		if ( count < 45) begin		//check if done
			if (count == 0 && rstCounter < 750000) begin //reset delay and signal
				count = count;
				rstCounter = rstCounter + 1'b1;
				
				if (rstCounter < 375000)
					resetOut = 1'b0;
				else
					resetOut = 1'b1;
				
				dataHold = 1'b0;
				clkHold = 1'b0;
				dOut = 8'b0;
				dc = 1'b0;
				
			end
			else begin				//none ending condition
				count = count + 1'b1;
				rstCounter = 0;
	
				
				dataHold = 1'b0;
				clkHold = 1'b1;
				
				resetOut = 1'b1;
				dOut = ra[count] [7:0];	
				dc = ra[count] [8];
			end
		end
		else if (count < 47)begin
			if (rstCounter < 3000000) begin //reset delay and signal
				count = count;
				rstCounter = rstCounter + 1'b1;
			
				dataHold = 1'b1;
				clkHold = 1'b0;
				
				resetOut = 1'b1;
				dOut = 8'b00000000;
				dc = 1'b0;
				
			end
			else begin				//none ending condition
				count = count + 1'b1;
				rstCounter = rstCounter;
				
				dataHold = 1'b0;
				clkHold = 1'b1;
				
				resetOut = 1'b1;
				dOut = ra[count] [7:0];	
				dc = ra[count] [8];
				
				
			end
		end
		else begin				//done condition
			count = 0;
			rstCounter = 0;
			
			dataHold = 1'b0;
			clkHold = 1'b1;
			
			resetOut = 1'b1;
			dOut = 8'b11111111;
			dc = 1'b0;
		end
end
endmodule
