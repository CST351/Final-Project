module sendByteSPI(
				input wire clk,
				input wire go,
				input wire [7:0]dIn,
				output wire done,
				output wire clkOut,
				output reg dOut
);

	parameter init = 4'h0, bit7 = 4'h1, bit6 = 4'h2, bit5 = 4'h3, bit4 = 4'h4, bit3 = 4'h5, bit2 = 4'h6, bit1 = 4'h7, bit0 = 4'h8;
	reg en;
	reg [3:0]state;
	
	assign done = (state == init) ? 1'b1 : 1'b0;
	assign clkOut = (state != init) ? clk : 1'b1;
	
	always @ (posedge clk)
		if (go)
			en = 1'b1;
		else begin
			if (state == bit0)
				en = 1'b0;
			else
				en = en;
		end
	
	always @ (negedge clk) begin
		case (state)
			init: begin
				if (en) 
					state <= bit7;
				else
					state <= init;
			end
			bit7:
				state <= bit6;
			bit6:
				state <= bit5;
			bit5:
				state <= bit4;
			bit4:
				state <= bit3;
			bit3:
				state <= bit2;
			bit2:
				state <= bit1;
			bit1:
				state <= bit0;
			bit0:
				state <= init;
			default:
				state <= init;
		endcase
	end
	
	always @ (*) begin
		case (state)
			init:
				dOut = dIn[0];	
			bit7:
				dOut = dIn[7];
			bit6:
				dOut = dIn[6];
			bit5:
				dOut = dIn[5];
			bit4:
				dOut = dIn[4];
			bit3:
				dOut = dIn[3];
			bit2:
				dOut = dIn[2];
			bit1:
				dOut = dIn[1];
			bit0:
				dOut = dIn[0];
			default:
				dOut = dIn[0];
		endcase
	end
endmodule
