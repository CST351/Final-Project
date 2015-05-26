module rngGenerator(
	input wire clk,
	input wire en,
	input wire load,
	input wire [19:0]seed,
	output wire [19:0]dataOut
);
	

	wire nextIn;
	wire [19:0] dataIn;

	assign nextIn = (dataOut[19]^dataOut[18]);
		
	my_ff F[19:0](
			.clk(clk),
			.en(en),
			.dataIn(dataIn),
			.dataOut(dataOut)
	);

	mux M[19:0](
			.sel(load), 
			.inA(seed), 
			.inB({dataOut[18:0], nextIn}),
			.out(dataIn)
	);

endmodule
