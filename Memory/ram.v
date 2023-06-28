//this is ram file

module ram(
	input [7:0] data_w, //8 bit data you want to write
	input [3:0] addr, //data address 16s
	input ce, //chip enable(read & write)
	input we, //write enable
	input clk, //clock
	output [7:0] data_r //data you want to read
);

reg [7:0] mem [15:0]; // 2 ^ 4 = 16
reg [3:0] addr_reg;
	
always @ (posedge clk) //posedge ce can be added
begin
    if (ce)  begin //can read and write
        if (we) begin //can write
            mem[addr] <= data_w; //save the data
        end
        
        //load the address
        addr_reg <= addr;
    end
end

//
assign data_r = mem[addr_reg];

endmodule
