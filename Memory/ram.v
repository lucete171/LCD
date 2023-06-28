//this is ram for small size

module ram(
	input [7:0] data_w, //data you want to write
	input [3:0] addr, //data address
	input we, //write enable
	input clk, //clock
	output [7:0] data_r //data you want to read
);

reg [7:0] ram [15:0];
reg [3:0] addr_reg;
	
always @ (posedge clk)
begin
	if (we) begin
		ram[addr] <= data_w;
	end
	
	addr_reg <= addr;	
end

assign data_r = ram[addr_reg];
	
endmodule

