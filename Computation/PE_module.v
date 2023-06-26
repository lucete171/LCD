//PE_module

module PE_module(a, b, clk, rst, a_out, b_out, out);
  
  input [7:0]a;
  input [7:0]b;
  
  input clk;
  input rst;
  
  output reg[7:0] a_out;
  output reg[7:0] b_out;
  output reg[7:0] out;
  
  reg cout;
  
  reg [7:0] multi_out;
  reg [7:0] sum = 8'd0;
  reg tmp;
  
  reg [7:0] reg_out;
  
  wire[7:0] a_bar;
  wire[7:0] b_bar;
  
  //a_out, b_out  
  d_flip_flop_behavioral_module out_1(.d(a), .clk(clk), .q(a_out), .q_bar(a_bar));
  d_flip_flop_behavioral_module out_2(.d(b), .clk(clk), .q(b_out), .q_bar(b_bar));
  
  //multiplier with and gate
  eight_multi MUT(.a(a), .b(b), .out(multi_out));
  
  //adder with eight bit adder
  eight_add_module ADD(.a(multi_out), .b(sum), .sum(out), .cout(tmp));
  
  assign sum = out;
  
  //accumulator with full adder
  eight_bit_register_behavioral_module EIGHT_REG(.in(out), .clk(clk), .rst(rst), .out(reg_out));

  
endmodule
  
  
  
