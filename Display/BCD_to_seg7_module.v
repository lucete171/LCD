module BCD_to_seg7_module(
     bcd,
     seg
    );
     
     
     input [3:0] bcd;
     output [6:0] seg;
     reg [6:0] seg;

    always @(bcd)
    begin
        case (bcd) //case statement
            4'b0000 : seg = 7'b1111110; //0
            4'b0001 : seg = 7'b0110000; //1
            4'b0010 : seg = 7'b1101101; //2
            4'b0011 : seg = 7'b1111001; //3
            4'b0100 : seg = 7'b0110011; //4
            4'b0101 : seg = 7'b1011011; //5
            4'b0110 : seg = 7'b1011111; //6
            4'b0111 : seg = 7'b1110010; //7
            4'b1000 : seg = 7'b1111111; //8
            4'b1001 : seg = 7'b1111011; //9
            //switch off 7 segment character when the bcd digit is not a decimal number.
            default : seg = 7'b0000000; 
        endcase
    end
    
endmodule
