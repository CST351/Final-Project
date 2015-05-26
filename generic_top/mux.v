module mux (
	input wire sel, inA, inB,
	output reg out
);

	always @ (*)
		if (sel)
			out = inA;
		else
			out = inB;
endmodule
