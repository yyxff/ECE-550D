module stage3(s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,c2,c3,c4,c5,c6,c7, result, overflow);


	input s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,c2,c3,c4,c5,c6,c7;
	output [9:0] result;
	output overflow;
	//0
	assign result[0] = s0;
	
	//1
	assign result[1] = s1;
	
	//2
	assign result[2] = s2;
	
	//3
	half_adder ha3(.a(s3), .b(c2), .s(result[3]), .c(c3_3));
	
	//4
	full_adder fa4(.a(s4), .b(c3), .cin(c3_3), .s(result[4]), .cout(c4_3));
	
	//5
	full_adder fa5(.a(s5), .b(c4), .cin(c4_3), .s(result[5]), .cout(c5_3));
	
	//6
	full_adder fa6(.a(s6), .b(c5), .cin(c5_3), .s(result[6]), .cout(c6_3));
	
	//7
	full_adder fa7(.a(s7), .b(c6), .cin(c6_3), .s(result[7]), .cout(c7_3));
	
	//8
	full_adder fa8(.a(s8), .b(c7), .cin(c7_3), .s(result[8]), .cout(c8_3));
	
	//9
	half_adder ha9(.a(s9), .b(c8_3), .s(result[9]), .c(c9_3));
	
	//10
	assign overflow = c9_3;
	
endmodule
	
	
	