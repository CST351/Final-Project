module my_ff(
	input wire clk,
	input wire en,
	input wire dataIn,
	output reg dataOut
);
	
	
	always @ (posedge clk) begin
		if (en)
			dataOut = dataIn;
		else
			dataOut = dataOut;
		end
endmodule
