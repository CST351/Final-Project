module Shift_Reg (
	input wire en, data, clk,
	output reg [7:0] data_reg);
	
	always @ (negedge clk)	// uses negedge of the keyboard clock
	begin
		if (en)	// enable signal from the State_Machine module
			data_reg = {data, data_reg [7:1]};	// when enabled, shift in the data, starting with the LSB
		else
			data_reg = data_reg;	// otherwise keep it the same
	
	end
endmodule
