//Single Port RAM
module SP_RAM(data_w, data_r, addr, ce, we, clk);

// input & output
input [7:0] data_w; //8 bit data you want to write
input clk; //clk
input ce; //chip enable(read & write)
input we; //write enable
input [5:0] addr; //address of data

output [7:0] data_r; // 8 bit data you want to read

// wire & regs
reg [7:0] mem [0:63]; 
reg [5:0] r_addr; //address you want to read


always @ (posedge clk)
begin
    if (ce)  begin //can read and write
        if (we) begin //can write
            mem[addr] <= data_w; //save the data
        end
        
        //load the address
        r_addr <= addr;
    end
end

//
assign data_r = mem[r_addr];

endmodule