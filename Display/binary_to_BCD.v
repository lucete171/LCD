module binary_to_BCD_module(
  input wire [7:0] binary,
  output wire [3:0] bcd1,bcd2,bcd3,bcd4 //bcd1=thousand bcd2=hunderd bcd3=ten bcd4=one
);

    always @(binary)
    bcd1=4'b0000; 
    begin
        case (bcd) //case statement
        8'b00000000: bcd2 = 4'b0000, bcd3 = 4'b0000, bcd4 = 4'b0000;
        8'b00000001: bcd2 = 4'b0000, bcd3 = 4'b0000, bcd4 = 4'b0001;
//...
        endcase
    end
    

endmodule



