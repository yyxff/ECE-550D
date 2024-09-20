module m5_counter(
	clk,
	reset,
	level,
	now_me,
	next_me,
	count_me);

	input clk,reset,level;
	output [2:0] now_me, next_me, count_me;
	
	localparam [2:0]
		me_0 = 3'b000,
		me_1 = 3'b001,
		me_2 = 3'b010,
		me_3 = 3'b011,
		me_4 = 3'b100,
		me_5 = 3'b101,
		me_6 = 3'b110,
		me_7 = 3'b111;

	reg [2:0] now_me, next_me, count_me;
	
	localparam [2:0]
		mo_0 = 3'b000,
		mo_1 = 3'b001,
		mo_2 = 3'b010,
		mo_3 = 3'b011,
		mo_4 = 3'b100,
		mo_5 = 3'b101,
		mo_6 = 3'b110,
		mo_7 = 3'b111;

	reg [2:0] now_mo, next_mo;
	
	always @(negedge clk, posedge reset)begin
		if(reset)begin
			now_me <= me_0;
			now_mo <= mo_0;
		end
		else begin
			now_me <= next_me;
			now_mo <= next_mo;
		end
	end
	
	
	//Mealy
	always @(now_me, level)begin
	
		// if level is 0, keep current state
		next_me <= now_me;
		count_me <= now_me;
		
		// if level is 1, transit the state by case
		case(now_me)
			me_0:
			if(level)begin
				next_me <= me_1;
				count_me <= 3'b001;
			end
			
			me_1:
			if(level)begin
				next_me <= me_2;
				count_me <= 3'b010;
			end
			
			me_2:
			if(level)begin
				next_me <= me_3;
				count_me <= 3'b011;
			end
			
			me_3:
			if(level)begin
				next_me <= me_4;
				count_me <= 3'b100;
			end
			
			me_4:
			if(level)begin
				next_me <= me_0;
				count_me <= 3'b000;
			end
			
			me_5:
			if(level)begin
				next_me <= me_0;
				count_me <= 3'b000;
			end
			
			me_6:
			if(level)begin
				next_me <= me_0;
				count_me <= 3'b000;
			end
			
			me_7:
			if(level)begin
				next_me <= me_0;
				count_me <= 3'b000;
			end
		endcase
	end
			
			
					
		
endmodule