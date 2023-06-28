//this file is for main memory module

module memory_module(
  input [7:0] data, //data input
  input [5:0] addr, //data address 0 ~ 64
  input clk, rst,
  
  input [1:0] en_INPUT, //enable for INPUT
  input [1:0] en_FILTER, //enable for FILTER
  input [1:0] en_OUT1, //enable for SM
  input [1:0] en_OUT2, //enable for PM1
  input [1:0] en_OUT3, //enable for PM2
  
  output [7:0] out_A, //matrix data you want
  output [7:0] out_F, //filter data you want'
  output [7:0] out_1, out_2, out_3 //output data you want
);

//address converter wrt enable variable _ this module will be separated 
reg [3:0] addr_A;
reg [2:0] addr_F;
reg [1:0] addr_o_1, addr_o_2, addr_o_3;
reg [4:0] run = 5'b00000;
reg tmp;

always @(addr)
begin
  if (addr < 16) begin // 4 X 4 -> 0 ~ 15
    addr_A = addr;
    run[0] = 1'b1;
  end
  else if ((addr >= 16) && (addr < 25)) begin // 3 X 3 -> 0 ~ 9
    tmp = addr - 16;
    addr_F = tmp;
    run[1] = 1'b1;
  end
  else if ((addr >= 25) && (addr < 29)) begin // 2 X 2 -> 0 ~ 3
    tmp = addr - 25;
    addr_o_1 = tmp;
    run[2] = 1'b1;
  end
  else if ((addr >= 29) && (addr < 33)) begin // 2 X 2 -> 0 ~ 3
    tmp = addr - 29;
    addr_o_2 = tmp;
    run[3] = 1'b1;
  end
  else if ((addr >= 33) && (addr < 37)) begin // 2 X 2 -> 0 ~ 3
    tmp = addr - 33;
    addr_o_3 = tmp;
    run[4] = 1'b1;
  end
end

//-----------------------------------------INPUT-------------------------------------------//
//RAM _ INPUT MATRIX
always @(posedge clk)
begin
  if (run[0] == 1'b1) begin
    ram INPUT_RAM(.data_w(data), .addr(addr_A), .ce(en_INPUT[1]), .we(en_INPUT[0]), .clk(clk), .data_r(out_A));
  end
  run[0] = 1'b0;
end

//-----------------------------------------FILTER------------------------------------------//
//RAM _ FILTER MATRIX
always @(posedge clk)
begin
  if (run[1] == 1'b1) begin
    ram FILTER_RAM(.data_w(data), .addr(addr_F), .ce(en_FILTER[1]), .we(en_FILTER[0]), .clk(clk), .data_r(out_F));  
  end
  run[1] = 1'b0;
end

//-----------------------------------------OUTPUT-------------------------------------------//
//RAM _ Output of Serial mode
always @(posedge clk)
begin
  if (run[2] == 1'b1) begin
    ram OUT1_RAM(.data_w(data), .addr(addr_o_1), .ce(en_OUT1[1]), .we(en_OUT1[0]), .clk(clk), .data_r(out_1));
  end
  run[2] = 1'b0;
end

//RAM _ Output of Parallel mode 1
always @(posedge clk)
begin
  if (run[3] == 1'b1) begin
    ram OUT2_RAM(.data_w(data), .addr(addr_o_2), .ce(en_OUT2[1]), .we(en_OUT2[0]), .clk(clk), .data_r(out_2));
  end
  run[3] = 1'b0;
end

//RAM _ Output of Parallel mode 2
always @(posedge clk)
begin
  if (run[4] == 1'b1) begin
    ram OUT3_RAM(.data_w(data), .addr(addr_o_3), .ce(en_OUT3[1]), .we(en_OUT3[0]), .clk(clk), .data_r(out_3));
  end
  run[4] = 1'b0;
end

endmodule
