//this file is for 8-bit multiplier

module eight_multi_module(a, b, out);
  
  input [7:0] a, b;
  
  output [7:0] out;
  
  wire [7:0] cout;
  wire [7:0] multi [0:7];
  wire [7:0] ? [0:7];
  
  //generate partial product
  genvar i, j;
  generate
    //Make partial product
    for(i=0; i < 8; i = i+1) begin ROW //a[i]
      for(j=0; j < 8; j = j+1) begin COLUMN //b[j]
        and_gate AND(
        .a(b[i]),
        .b(a[j]),
        .out(multi[i][j])
        );
    end
    
    //Add partial product
    for(j=0; j < 8; j = j+1) begin PART_ADD
      eight_add_module ADD(
      .a(),
      .b(),
      .sum(),
      .cout()
      );
    end
  endgenerate
    
  
endmodule
  
  

