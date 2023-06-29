//This is 3 bit up down counter based on Moore state machine

module top_module(clk, out_digit, out_data);
	input clk;
  output [7:0] out_digit;
	output [6:0] out_data;
  wire [7:0] mux_output; //for c in display
  wire rst;
  
  wire [7:0] data; //data input
  wire [3:0] addr_A0, addr_A1, addr_A2; //0 is to save
  wire [3:0] addr_F0, addr_F1, addr_F2; //0 is to save
  wire [1:0] addr_S0, addr_S1, addr_S2, addr_S3;
  wire [1:0] addr_P1_0, addr_P1_1, addr_P1_2, addr_P1_3;
  wire [1:0] addr_P2_0, addr_P2_1, addr_P2_2, addr_P2_3;
  
  wire [1:0] en_INP; //enable for INPUT
  wire [1:0] en_FIL; //enable for FILTER
  wire [1:0] en_S; //enable for SM
  wire [1:0] en_P1; //enable for PM1
  wire [1:0] en_P2; //enable for PM2
  
  wire [7:0] out_A0, out_A1, out_A2; //matrix data you want
  wire [7:0] out_F0, out_F1, out_F2; //filter data you want
  wire [7:0] out_S0, out_S1, out_S2, out_S3; //Serial mode output
  wire [7:0] out_P1_0, out_P1_1, out_P1_2, out_P1_3; //Parallel mode 1 output
  wire [7:0] out_P2_0, out_P2_1, out_P2_2, out_P2_3; //Parallel mode 2 output
  
  wire [2:0] cal_sel;	//CM ctrl	
  wire mux_reset; //s ctrl
  wire p1_en;	//p1 ctrl: 
  wire [1:0] p2_en;
  wire [2:0] c_sel;//p2 ctrl 
  wire [3:0] dis_en;//display ctrl: dis_en;
  
  Controller ctrl(.clk(clk), .reset(rst), .cal_sel(cal_sel), .mux_reset(mux_reset), .p1_en(p1_en),	.p2_en(p2_en), .c_sel(c_sel),
   .dis_en(dis_en), .addr_a1(addr_A0), .addr_a2(addr_A1), .addr_a3(addr_A2), .addr_b1(addr_B0), .addr_b2(addr_B1), ,addr_b3(addr_B2), 
   .addr_S0(addr_S0), .addr_S1(addr_S1), .addr_S2(addr_S2), .addr_S3(addr_S3), .addr_P1_0(addr_P1_0), .addr_P1_1(addr_P1_1),
  .addr_P1_2(addr_P1_2), .addr_P1_3(addr_P1_3), .addr_P2_0(addr_P2_0), .addr_P2_1(addr_P2_1), .addr_P2_2(addr_P2_2), .addr_P2_3(addr_P2_3), 
  .en_INP(en_INP), .en_FIL(en_FIL), .en_S(en_S), .en_P1(en_P1), .en_P2(en_P2));
  
  //need mux for output input
  CM_Serial Serial(.a(), .b(), .clk(clk), .rst(rst), .mux_reset(mux_reset), .out(out_conv));
  
  SA_3x3 Parallel1(.clk(clk), .rst(rst), .A_in_1(), .A_in_2(), .A_in_3(), .B_in_1(), .B_in_2(), .B_in_3(), .P1_en(p1_en) , .C_out());

  SA_2x2 Parallel2(.clk(clk), .rst(rst), .A_in_1(), .A_in_2(), .B_in_1(), .B_in_2(), .P2_en(p2_en), .c_sel(c_sel), .SAout());
  

  
	memory_module memory(.data(out_conv), .clk(clk), .rst(rst), .addr_a1(addr_A0), .addr_a2(addr_A1), .addr_a3(addr_A2), .addr_b1(addr_B0), .addr_b2(addr_B1), ,addr_b3(addr_B2), 
   .addr_S0(addr_S0), .addr_S1(addr_S1), .addr_S2(addr_S2), .addr_S3(addr_S3), .addr_P1_0(addr_P1_0), .addr_P1_1(addr_P1_1),
  .addr_P1_2(addr_P1_2), .addr_P1_3(addr_P1_3), .addr_P2_0(addr_P2_0), .addr_P2_1(addr_P2_1), .addr_P2_2(addr_P2_2), .addr_P2_3(addr_P2_3),
  .en_INP(en_INP), .en_FIL(en_FIL), .en_S(en_S),  .en_P1(en_P1), .en_P2(en_P2), .out_A0(out_A0), .out_A1(out_A1), .out_A2(out_A2), .out_F0(out_F0), .out_F1(out_F1), .out_F2(out_F2),
   .out_S0(out_S0), .out_S1(out_S1), .out_S2(out_S2), .out_S3(out_S3), .out_P1_0(out_P1_0), .out_P1_1(out_P1_1), .out_P1_2(out_P1_2),
   .out_P1_3(out_P1_3), .out_P2_0(out_P2_0), .out_P2_1(out_P2_1), .out_P2_2(out_P2_2), .out_P2_3(out_P2_3));

  display_select 12MUX(.d_en(dis_en), .A1(out_S0), .A2(out_S1), .A3(out_S2), .A4(out_S3),
   .B1(out_P1_0), .B2(out_P1_1), .B3(out_P1_2), .B4(out_P1_3), 
   .C1(out_P2_0), .C2(out_P2_1), .C3(out_P2_2), .C4(out_P2_3), .out(mux_output));
   
	seven_seg_display display(.clk(clk), .reset(rst), .c(mux_output), .digit(out_digit), .seg_data(out_data));
endmodule

