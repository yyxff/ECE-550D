`timescale 1 ns / 100 ps
module m5_counter_tb();
	reg w;
	reg clk;
	reg reset;
	
	wire [2:0] count_me, count_mo;
	wire [2:0] now_me,next_me, now_mo, next_mo;
	wire out_me, out_mo;
	
	m5_counter test_m5_counter(.clk(clk), .reset(reset),.w(w),.now_me(now_me), .next_me(next_me), .count_me(count_me), .out_me(out_me), .now_mo(now_mo), .next_mo(next_mo), .count_mo(count_mo), .out_mo(out_mo));
	
	initial begin
		reset = 1'b1;
		clk = 1'b0;
		# 5 reset = 1'b0;
		
		@(negedge clk);
		w = 1'b0;
		@(negedge clk);
		w = 1'b1;
		@(negedge clk);
		w = 1'b0;
		@(negedge clk);
		w = 1'b1;
		@(negedge clk);
		w = 1'b1;
		@(negedge clk);
		w = 1'b1;
		@(negedge clk);
		w = 1'b1;
		@(negedge clk);
		w = 1'b1;
		@(negedge clk);
		w = 1'b1;
		@(negedge clk);
		w = 1'b0;
		@(negedge clk);
		w = 1'b1;
		@(negedge clk);
		w = 1'b1;
		@(negedge clk);
		w = 1'b1;
		
		@(negedge clk);
		$stop;
	end
	
	
	// clock
	always
		#10 clk = ~clk;
		
endmodule
		
	