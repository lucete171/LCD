//this file is for 8-bit adder

module eight_bit_add_module(a, b, sum, cout);
  
  input [7:0] a, b;
  
  output [7:0] sum;
  output reg cout;
  
  wire [7:0] carry;
  
  assign carry[0] = 1'b0;
  
  genvar i;
  generate
    for (i=0; i<8; i = i+1) begin: EIGHT_ADDER
      full_adder_behavioral_module FA(
      .a(a[i]),
      .b(b[i]),
      .cin(carry[i]),
      .sum(sum[i]),
      .cout(i==7 ? cout : carry[i+1])
      );
    end
  endgenerate
  
endmodule
      
      
      
  
  
  
  

