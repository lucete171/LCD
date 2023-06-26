//This is a 8-bit register module.

module eight_bit_register_behavioral_module(in, clk, rst, out);

	input [7:0] in;
	input clk; 
	input rst; 
	
	output [7:0] out;
	reg [7:0] out;	
	
	always@(posedge clk)
	begin
		if(rst == 1'b1)
			out <= 8'd0; 
		else
		begin
			out <= in;
		end
	end



endmodule
