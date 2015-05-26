module Clock_Div_Touch (
	input wire clk,
	output reg div_clk);
	
	reg [14:0] count;
	
	always @ (posedge clk)	// using 50Mhz clock
	begin
		if (count < 25000)		// while count < 250000, keep clock signal the same
			div_clk = div_clk;	// generates 1KHz clock
		else	
		begin
			div_clk = ~div_clk;	// else invert the clock
			count = 0;
		end	
		count = count + 1'b1;
	end
	endmodule
	