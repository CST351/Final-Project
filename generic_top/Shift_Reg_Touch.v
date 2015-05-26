module Shift_Reg_Touch (
	input wire en, data, clk,
	output reg [7:0] data_reg);
	
	always @ (negedge clk)	// uses negedge of the keyboard clock
	begin
		if (en)	// enable signal from the State_Machine module
			data_reg = {data_reg [6:0], data};	// when enabled, shift in the data, starting with the LSB
		else
			data_reg = data_reg;	// otherwise keep it the same
	end
endmodule
