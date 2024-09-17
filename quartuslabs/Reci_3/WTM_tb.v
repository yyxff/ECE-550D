
`timescale 1 ns / 100 ps
module WTM_tb();

	reg clock;
	reg [4:0] a, b;
	wire [9:0] result;
	wire overflow;
	integer num_errors;
	
	WTM wtm_test(.a(a), .b(b), .result(result), .c(overflow));
	
	
 
		
		
	// begin simulation
 	initial begin
		$display($time, " simulation start");
       	
      clock = 1'b0;
		num_errors = 0;
	
		@(negedge clock);
			a = 5'b00000;
			b = 5'b00000;
		@(negedge clock);
			if(result !== 10'b0000000000) begin
				 $display("**Error in (test 1); expected: %b, actual: %b", 10'b0000000000, result);
				 num_errors = num_errors + 1;
			end
			if(overflow !== 1'b0) begin
				 $display("**Error in (test 1); expected: %b, actual: %b", 1'b0, overflow);
				 num_errors = num_errors + 1;
			end
		
		@(negedge clock);
			a = 5'b00010;
			b = 5'b00111;
		@(negedge clock);
			if(result !== 10'b0000001110) begin
				 $display("**Error in (test 1); expected: %b, actual: %b", 10'b0000001110, result);
				 num_errors = num_errors + 1;
			end
			if(overflow !== 1'b0) begin
				 $display("**Error in (test 1); expected: %b, actual: %b", 1'b0, overflow);
				 num_errors = num_errors + 1;
			end
		
		@(negedge clock);
			a = 5'b11111;
			b = 5'b11111;
		@(negedge clock);
			if(result !== 10'b1111000001) begin
				 $display("**Error in (test 1); expected: %b, actual: %b", 10'b1111000001, result);
				 num_errors = num_errors + 1;
			end
			if(overflow !== 1'b0) begin
				 $display("**Error in (test 1); expected: %b, actual: %b", 1'b0, overflow);
				 num_errors = num_errors + 1;
			end
		@(negedge clock);
			$stop;
	   
 	end

	// toggle clock every 10 timescale units
 	always
      #10 clock = ~clock;
		
endmodule