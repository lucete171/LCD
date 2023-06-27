`timescale 1ns/1ns

//testbench of computation of processing element(PE)
module tb_sm;
  reg CLK;
  reg RESET;
  
  reg [7:0] A_IN, B_IN;
  
  //PE MODULE
  wire [7:0] OUTPUT, A_OUT, B_OUT;
  
  //EIGHT ADD
  reg [7:0] OUTPUT_ADD;
  reg COUT_ADD;
  
  //EIGHT_MUL
  reg [7:0] OUTPUT_MUL;
  
  //PE_module PE_1(.a(A_IN), .b(B_IN), .clk(CLK), .rst(RESET), .a_out(A_OUT), .b_out(B_OUT), .out(OUTPUT));
  eight_bit_add_module ADD_TEST(.a(A_IN), .b(B_IN), .sum(OUTPUT_ADD), .cout(COUT_ADD));
  
  eight_bit_multi_module MUL_TEST(.a(A_IN), .b(B_IN), .out(OUTPUT_MUL));
  
  initial
  begin
    RESET = 1'b0;
    A_IN = 8'd13;
    B_IN = 8'd11;
  end
  
  initial
  begin
    #200 //delay of PE
    A_IN = 8'd1;
    B_IN = 8'd3;
  end
  
  
endmodule
