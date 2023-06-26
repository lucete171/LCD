//PE_module

module PE_module(a, b, clk, rst, a_out, b_out, out);
  
  input [7:0]a;
  input [7:0]b;
  
  input clk;
  input rst;
  
  output reg[7:0] a_out;
  output reg[7:0] b_out;
  output reg[7:0] out;
  
  wire[7:0] a_bar;
  wire[7:0] b_bar;
  
  //a_out, b_out  
  d_flip_flop_behavioral_module out_1(.d(a), .clk(clk), .q(a_out), .q_bar(a_bar));
  d_flip_flop_behavioral_module out_2(.d(b), .clk(clk), .q(b_out), .q_bar(b_bar));
  
  //multiplier with and gate
  
  
  
  //adder with full adder
  
  
  
  //accumulator with full adder
  
endmodule
  
  
  