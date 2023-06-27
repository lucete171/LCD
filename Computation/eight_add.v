//this file is for 8-bit adder

module eight_bit_add_module(a, b, sum, cout);
  
  input [7:0] a, b;
  
  output [7:0] sum;
  output cout;
  
  wire [7:0] carry;
  
  genvar i;
  generate
    for (i=0; i<8; i = i+1) begin: EIGHT_ADDER
      full_adder_behavioral_module FA(
      .a(a[i]),
      .b(b[i]),
      .cin(i==0 ? 0 : carry[i-1]),
      .sum(sum[i]),
      .cout(i==7 ? cout : carry[i])
      );
    end
  endgenerate
  
endmodule
      
      
      
  
  
  
  
