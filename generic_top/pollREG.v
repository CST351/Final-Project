module pollREG(
		input wire en,
		input wire [19:0]dataIn,
		output reg [19:0]dataOut
);

	always @ ( posedge en )
		if ( en )
			dataOut = dataIn;
		else
			dataOut = dataOut;

endmodule
		