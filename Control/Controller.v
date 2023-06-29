module Controller(
	input clk,
	input reset_n,

//write ctrl
//module ctrl [2:0]cal_sel	
//serial ctrl: mux_reset	
//p1 ctrl: p1_en	
//p2 ctrl: [1:0] p2_en, [2:0] c_sel
//display ctrl: dis_en
);

reg [7:0] state;
reg [7:0] next_state;

reg [26:0] clock_count; //17'd99999? does it have to be much longer?=>1s needs to be 20'd999999

parameter [26:0] COUNT_MAX = 99999999;

//parameter setting//
parameter add11=4'd0, add12=4'd1, add13=4'd2, add14=4'd3, add21=4'd4, add22=4'd5, add23=4'd6, add24=4'd7, add31=4'd8, add32=4'd9, add33=4'd10, 
add34=4'd11, add41=4'd12, add42=4'd13, add43=4'd14, add44=4'd15, bdd11=4'd0, bdd12=4'd1, bdd13=4'd2, bdd21=4'd3, bdd22=4'd4, bdd23=4'd5, bdd31=4'd6, bdd32=4'd7, bdd33=4'd8; 

always @ (state or clk_cnt)//DISPLAY STATE
begin
	case (state)
		DISPLAY_S_C11 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_S_C11;
		end
		DISPLAY_S_C12 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_S_C12;
		end
		DISPLAY_S_C21 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_S_C21;
		end
		DISPLAY_S_C22 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_S_C22;
		end
		DISPLAY_3X3_C11 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_3X3_C11;
		end
		DISPLAY_3X3_C12 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_3X3_C12;
		end
		DISPLAY_3X3_C21 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_3X3_C21;
		end
		DISPLAY_3X3_C22 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_3X3_C22;
		end
		DISPLAY_2X2_C11 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_2X2_C11;
		end
		DISPLAY_2X2_C12 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_2X2_C12;
		end
		DISPLAY_2X2_C21 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_2X2_C21;
		end													
		DISPLAY_2X2_C22 : begin
			if (clk_cnt == COUNT_MAX)
				next_state = state + 8'd1;
			else
				next_state = DISPLAY_2X2_C22;		
		end
		END : begin
			next_state = END;
		end
		default : begin
			next_state = state + 8'd1;
		end
	endcase
end

always @ (state) //OUTPUT
begin
  //initial rst
	case (state)
		INITIAL : begin
//initial rst
		end
		START : begin
//MEMORY LOAD
		end
///////////////////////////////////////////////////////////////////////
		// Serial mode
    // Serial mode
		SERIAL_START : begin //t=0
			addr_a1 <= add11;
			addr_b1 <= bdd33;
		end
		// C11 starts
		8'd29 : begin
		  SERIAL_C11_START : begin
			mux_reset = 1'b1; 
			addr_a2 <= add12;
			addr_b2 <= bdd32;
		end
		8'd30 : begin
			addr_a3 <= add13;
			addr_b3 <= bdd31;
		end
		8'd31 : begin
			addr_a1 <= add21;
			addr_b1 <= bdd23;
		end
		8'd32 : begin
			addr_a2 <= add22;
			addr_b2 <= bdd22;
		end
		8'd33 : begin
			addr_a3 <= add23;
			addr_b3 <= bdd21;
		end
		8'd34 : begin
			addr_a1 <= add31;
			addr_b1 <= bdd13;
		end
		8'd35 : begin
			addr_a2 <= add32;
			addr_b2 <= bdd12;
		end
		8'd35 : begin
			addr_a3 <= add33;
			addr_b3 <= bdd11;
		end
		
	  SERIAL_C11_END : begin
			addr_a1 <= add12;  
			addr_b1 <= bdd33;
			//Memwrite
		end
		// C12 START				
		SERIAL_C12_START : begin
			mux_reset = 1'b1;
			addr_a2 <= add13;
			addr_b2 <= bdd32;
			// C11 stored
		end
		8'd39 : begin
			addr_a3 <= add14;
			addr_b3 <= bdd31;
		end
		8'd40 : begin
			addr_a1 <= add22;
			addr_b1 <= bdd23;
		end
		8'd41 : begin
			addr_a2 <= add23;
			addr_b2 <= bdd22;
		end
		8'd42 : begin
			addr_a3 <= add24;
			addr_b3 <= bdd21;
		end
		8'd43 : begin
			addr_a1 <= add32;
			addr_b1 <= bdd13;
		end
		8'd44 : begin
			addr_a2 <= add33;
			addr_b2 <= bdd12;
		end
		8'd45 : begin	
			addr_a3 <= add34;
			addr_b3 <= bdd11;
		end

		SERIAL_C12_END : begin
			addr_a1 <= add21;
			addr_b1 <= bdd33;
			//Memwrite
		end
		// C21 starts				
		SERIAL_C21_START : begin 
			mux_reset = 1'b1;
			addr_a2 <= add22;
			addr_b2<= bdd32;
		end
		// C12 stored  
		8'd48 : begin
			addr_a3 <= add23;
			addr_b3 <= bdd31;
		end
		8'd49 : begin
			addr_a1 <= add31;
			addr_b1 <= bdd23;
		end
		8'd50 : begin
			addr_a2 <= add32;
			addr_b2 <= bdd22;
		end
		8'd51 : begin
			addr_a3 <= add33;
			addr_b3 <= bdd21;
		end
		8'd52 : begin
			addr_a1 <= add41;
			addr_b1 <= bdd13;
		end
		8'd53 : begin
			addr_a2 <= add42;
			addr_b2 <= bdd12;
		end
		8'd54 : begin
			addr_a3 <= add43;
			addr_b3 <= bdd11;
		end
    SERIAL_C21_END : begin
			addr_a1 <= add22;
			addr_b1 <= bdd33;
		end
		// C22 starts
		SERIAL_C22_START : begin
			mux_reset = 1'b1;
		  addr_a2 <= add23;
			addr_b2 <= bdd32;
		// C21 stored	
		end
		8'd57 : begin
			addr_a3 <= add24;
			addr_b3 <= bdd31;
		end
		8'd59 : begin
			addr_a1 <= add32;
			addr_b1 <= bdd23;
		end
		8'd60 : begin
		 addr_a2 <= add33;
			addr_b2 <= bdd22;
		end
		8'd61 : begin
			addr_a3 <= add34;
			addr_b3 <= bdd21;
		end
		8'd62 : begin
			addr_a1 <= add42;
			addr_b1 <= bdd13;
		end
			8'd63 : begin
			addr_a2 <= add43;
			addr_b2 <= bdd12;	
		end
			8'd64 : begin
			addr_a3 <= add44;
			addr_b3 <= bdd11;		
		end
		SERIAL_C22_END : begin
		end
		SERIAL_END : begin
		  
		end				// C22 stored
		
		
//////////////////////////////////////////////////////////////////////
		// Parallel1 mode
		PARALLEL1_START : begin
			addr_filter1 = 4'd8;
			addr_filter2 = 4'd5;
			addr_filter3 = 4'd2;
		end

		end
		8'd82 : begin
			out_en3 = 1'b1;
			hold = 1'b1;
		end
		PARALLEL1_C22_END : begin
			hold = 1'b1;
			check = 1'b1;
			se_parallel1 = 1'b1; index = 2'd3;
		end						// C22 stored
		
///////////////////////////////////////////////////////////////////////

		// Parallel2 mode
		//
		PARALLEL2_START : begin //t0
			addr_b1 =bdd32; addr_b2=bdd33;
		end
		// C11 starts addr_a1 add bdd
		PARALLEL2_C11_START : begin //t1
		  //computing module change maybe next state
			addr_b1 =bdd31; addr_b2=(0 to b);//else at parallel1
      p2_en=2'b11;
		end
		8'd86 : begin //t2
			addr_a1 =add13; addr_a2=add11;
		end
		8'd87 : begin //t3
		  p2_en = 2'b00; //filter keep
			addr_a1 =add14; addr_a2=add12;
		end
		8'd88 : begin //t4
			addr_a1 =add00; //0 at a1
			addr_a2=add13;
			
		end
		8'd89 : begin //t5-get partial sum of c11
			addr_a1 =add23; addr_a2=add21;
			c_sel=3'b100;
		end
		8'd90 : begin //t6-get p_sum for c12
			addr_a1 =add24; addr_a2=add22;
			c_sel=3'b101;
		end
		8'd91 : begin //t7
			addr_a1 =add00; addr_a2=add23; //0
			addr_b1 =bdd22; addr_b2=bdd23; //0
		end
		8'd92 : begin //t8-get c21
			addr_b1 =bdd22; addr_b2=bdd23; //0
		end
		8'd93 : begin //t9-get
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd94 : begin //t10
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd95 : begin //t11
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd96 : begin //t12
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd97 : begin //t13
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd97 : begin //t14
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd97 : begin //t15
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 			
		end	
		8'd94 : begin //t16
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd95 : begin //t17
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd96 : begin //t18
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd97 : begin //t19
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd97 : begin //t20
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd97 : begin //t21
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 			
		end	
		8'd97 : begin //t22
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd97 : begin //t23
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 
		end
		8'd97 : begin //t24
			addr_a1 =add00; addr_a2=add23; 
			addr_b1 =bdd22; addr_b2=bdd23; 			
		end	
		
		// C12 starts
		PARALLEL2_C12_START : begin
			addr_filter1 = 4'd3; addr_filter2 = 4'd0;
			out_choice = 1'b1;
			out_en1 = 1'b0; out_en2 = 1'b1;
			check_temp = 1'b1;
		end
		PARALLEL2_C11_END : begin
			addr_in1 = 4'd1;
			out_choice = 1'b1;
			out_en1 = 1'b1; out_en2 = 1'b1;
			check = 1'b1;
			se_parallel2 = 1'b1; index = 2'd0;
		end					// C11 stored
		8'd102 : begin
			addr_in1 = 4'd2; addr_in2 = 4'd3;
			out_choice = 1'b0;
			out_en1 = 1'b1; out_en2 = 1'b0;
			hold = 1'b1;
			result_clear = 1'b1;
		end
		8'd103 : begin
			out_choice = 1'b0;
			out_en1 = 1'b1; out_en2 = 1'b1;
			hold = 1'b1;
		end
		////////
		end
		8'd145 : begin
			check_temp = 1'b1;
		end
		PARALLEL2_C22_END : begin
			check = 1'b1;
			se_parallel2 = 1'b1; index = 2'd3;
		end					// C22 stored
		
		//timing consideration
		DISPLAY_S_C11 : begin
    dis_en=1'b1;
    //memory address for out_conv
		end
		DISPLAY_S_C12 : begin
    //memory address for out_conv
		end
		DISPLAY_S_C21 : begin
    //memory address for out_conv
		end
		DISPLAY_S_C22 : begin
    //memory address for out_conv
		end
		DISPLAY_3X3_C11 : begin
    //memory address for out_conv
		end
		DISPLAY_3X3_C12 : begin
    //memory address for out_conv
		end
		DISPLAY_3X3_C21 : begin
      //memory address for out_conv
		end
		DISPLAY_3X3_C22 : begin
      //memory address for out_conv
		end
		DISPLAY_2X2_C11 : begin
      //memory address for out_conv
		end
		DISPLAY_2X2_C12 : begin
      dis_en=1'b1;
      //memory address for out_conv
		end
		DISPLAY_2X2_C21 : begin
      //memory address for out_conv
		end
		DISPLAY_2X2_C22 : begin
      dis_en=1'b1;
      //memory address for out_conv
		end
		END : begin
			dis_en =1'b0;
		end

	endcase
end

always @ (posedge clk or negedge rst_n) //state_transition
begin
	if (~rst_n)
		state <= INITIAL;
	else
		state <= next_state;
end

always @ (posedge clk or posedge rst) //clock counter
begin 
	if (rst) begin
		clk_cnt <= 27'd0;
	end else begin
		case (state)
      DISPLAY_S_C11, DISPLAY_S_C12, DISPLAY_S_C_21, DISPLAY_S_C_22,
      DISPLAY_3X3_C11, DISPLAY_3X3_C12, DISPLAY_3X3_C21, DISPLAY_3X3_C22,
      DISPLAY_2X2_C11, DISPLAY_2X2_C12, DISPLAY_2X2_C21, DISPLAY_2X2_C22 : begin
				if (clk_cnt == COUNT_MAX)
					clk_cnt <= 27'd0;
				else
					clk_cnt <= clk_cnt + 27'd1;	
			end
			default : begin
				clk_cnt <= 27'd0;
			end
		endcase
	end
end

endmodule






