`timescale 1ns/1ns

module tb_display;
	reg CLK;
	reg RESET_N;
	
    reg [7:0] C; //input c
    
    wire [6:0] SEG_DATA;
    wire [7:0] DIGIT;
    
    seven_seg_display Seven_segment_LED_Display(.clk(CLK), .reset_n(RESET_N), .c(C), .digit(DIGIT), .seg_data(SEG_DATA));
    
    initial
    begin
    CLK = 1'b0;
    RESET_N = 1'b1;
    
    C = 8'd193;
    #1000000000 C = 8'd10;
    #1000000000 C = 8'd150;
    #1000000000 C = 8'd1;
    
    #1000000000 C = 8'd193;
    #1000000000 C = 8'd10;
    #1000000000 C = 8'd150;
    #1000000000 C = 8'd1;
    

    end
          
    initial
    begin
        forever
        begin
            #5 CLK = !CLK;
        end         
    end
    
endmodule
