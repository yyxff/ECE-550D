module m5_counter(
	clk,
	reset,
	w,
	now_me,
	next_me,
	count_me,
	out_me,
	now_mo,
	next_mo,
	count_mo,
	out_mo);

	input clk,reset,w;
	output [2:0] now_me, next_me, count_me;
	output out_me;
	output [2:0] now_mo, next_mo, count_mo;
	output out_mo;
	
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
	reg out_me;
	
	localparam [2:0]
		mo_0 = 3'b000,
		mo_1 = 3'b001,
		mo_2 = 3'b010,
		mo_3 = 3'b011,
		mo_4 = 3'b100,
		mo_5 = 3'b101,
		mo_6 = 3'b110,
		mo_7 = 3'b111;

	reg [2:0] now_mo, next_mo, count_mo;
	reg out_mo;
	
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
	always @(now_me, w)begin
	
		// if w is 0, keep current state
		next_me <= now_me;
		count_me <= now_me;
		out_me <= 1'b0;
		
		// if w is 1, transit the state by case
		case(now_me)
			me_0:
			if(w)begin
				next_me <= me_1;
				count_me <= 3'b001;
			end
			
			me_1:
			if(w)begin
				next_me <= me_2;
				count_me <= 3'b010;
			end
			
			me_2:
			if(w)begin
				next_me <= me_3;
				count_me <= 3'b011;
			end
			
			me_3:
			if(w)begin
				next_me <= me_4;
				count_me <= 3'b100;
			end
			
			me_4:begin
			out_me <= 1'b1;
			if(w)begin
				next_me <= me_0;
				count_me <= 3'b000;
			end
			end
			
			me_5:begin
			next_me <= me_0;
			count_me <= 3'b000;
			end
			
			me_6:begin
			next_me <= me_0;
			count_me <= 3'b000;
			end
			
			me_7:begin
			next_me <= me_0;
			count_me <= 3'b000;
			end
		endcase
	end
	
	
	//Moore 
	always @(now_mo, w)begin
		next_mo <= now_mo;
		out_mo <= 1'b0;
		
		case(now_mo)
			mo_0:begin
			count_mo <= mo_0;
			if(w)begin
				next_mo <= mo_1;
			end
			end
			
			mo_1:begin
			count_mo <= mo_1;
			if(w)begin
				next_mo <= mo_2;
			end
			end
			
			mo_2:begin
			count_mo <= mo_2;
			if(w)begin
				next_mo <= mo_3;
			end
			end
			
			mo_3:begin
			count_mo <= mo_3;
			if(w)begin
				next_mo <= mo_4;
			end
			end
			
			mo_4:begin
			out_mo <= 1'b1;
			count_mo <= mo_4;
			if(w)begin
				next_mo <= mo_0;
			end
			end
			
			mo_5:begin
			count_mo <= mo_0;
			next_mo <= mo_0;
			end
			
			mo_6:begin
			count_mo <= mo_0;
			next_mo <= mo_0;
			end
			
			mo_7:begin
			count_mo <= mo_0;
			next_mo <= mo_0;
			end
		endcase
	end
			
			
					
		
endmodule