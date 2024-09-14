module stage2(s0,s1,	s2,s3,s4,s5,s6,s7,s8,s32,s42,s52,c1,c2,c3,c4,c5,c6,c7,c52, result, overflow);

	input s0,s1,	s2,s3,s4,s5,s6,s7,s8,s32,s42,s52,c1,c2,c3,c4,c5,c6,c7,c52;
	output [9:0] result;
	output overflow;
	
	
	// 0
	
	// 1
	
	//2
	half_adder ha2(.a(s2), .b(c1), .s(s2_2), .c(c2_2));
	
	//3
	full_adder fa3(.a(s3), .b(c2), .cin(s32), .s(s3_2), .cout(c3_2));
	
	//4
	full_adder fa4(.a(s4), .b(c3), .cin(s42), .s(s4_2), .cout(c4_2));
	
	//5
	full_adder fa5(.a(s5), .b(c4), .cin(s52), .s(s5_2), .cout(c5_2));
	
	//6
	full_adder fa6(.a(s6), .b(c5), .cin(c52), .s(s6_2), .cout(c6_2));
	
	//7
	half_adder ha7(.a(s7), .b(c6), .s(s7_2), .c(c7_2));
	
	//8
	half_adder ha8(.a(s8), .b(c7), .s(s8_2), .c(c8_2));
	
	stage3 st3(.s0(s0), .s1(s1), .s2(s2_2), .s3(s3_2), .s4(s4_2), .s5(s5_2), .s6(s6_2), .s7(s7_2), .s8(s8_2), .s9(c8_2), .c2(c2_2), .c3(c3_2), .c4(c4_2), .c5(c5_2), .c6(c6_2), .c7(c7_2), .result(result), .overflow(overflow));
	
	
endmodule