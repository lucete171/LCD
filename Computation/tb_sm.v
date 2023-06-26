`timescale 1ns/1ns

//testbench of computation of processing element(PE)
module tb_sm;
  reg CLK;
  reg RESET;
  
  reg [7:0] A_IN, B_IN;
  
  wire [7:0] OUTPUT, A_OUT, B_OUT;
  
  PE_module PE_1(.a(A_IN), .b(B_IN), .clk(CLK), .rst(RESET), .a_out(A_OUT), .b_out(B_OUT), .out(OUTPUT));
  
  initial
  begin
    OUTPUT=1'b0;
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
