module stage1(a, 
					b,
					result,
					overflow
					);
					
	input [4:0] a, b;
	output [9:0] result;
	output overflow;
	
	wire s0,s1,	s2,s3,s4,s5,s6,s7,s8,s32, s42,s52,c1,c2,c3,c4,c5,c6,c7,c52;

	wire m00,m10,m01,m20,m11,m02,m30,m21,m12,m03,m40,m31,m22,m13,m04,m41,m32,m23,m14,m42,m33,m24,m43,m34,m44;
	wire c42;
	// 0 a0b0
	and(m00, a[0], b[0]);
	
	// 1 a1b0,a0b1
	and(m10, a[1], b[0]);
	and(m01, a[0], b[1]);
	
	half_adder ha10(.a(m10), .b(m01), .s(s1), .c(c1));
	
	// 2
	and(m20, a[2], b[0]);
	and(m11, a[1], b[1]);
	and(m02, a[0], b[2]);
	
	full_adder fa20(.a(m20), .b(m11), .cin(m02),  .s(s2), .cout(c2));
	
	// 3 
	and(m30, a[3], b[0]);
	and(m21, a[2], b[1]);
	and(m12, a[1], b[2]);
	and(m03, a[0], b[3]);
	
	full_adder fa30(.a(m21), .b(m12), .cin(m03),  .s(s3), .cout(c3));
	
	// 4
	and(m40, a[4], b[0]);
	and(m31, a[3], b[1]);
	and(m22, a[2], b[2]);
	and(m13, a[1], b[3]);
	and(m04, a[0], b[4]);
	
	full_adder fa40(.a(m22), .b(m13), .cin(m04), .s(s4), .cout(c4));
	half_adder ha41(.a(m40), .b(m31), .s(s42), .c(c42));
	
	// 5 
	and(m41, a[4], b[1]);
	and(m32, a[3], b[2]);
	and(m23, a[2], b[3]);
	and(m14, a[1], b[4]);
	
	full_adder fa50(.a(m32), .b(m23), .cin(m14), .s(s5), .cout(c5));
	half_adder ha51(.a(m41), .b(c42), .s(s52), .c(c52));

	
	// 6 
	and(m42, a[4], b[2]);
	and(m33, a[3], b[3]);
	and(m24, a[2], b[4]);
	
	full_adder fa60(.a(m42), .b(m33), .cin(m24), .s(s6), .cout(c6));
	
	// 7 
	and(m43, a[4], b[3]);
	and(m34, a[3], b[4]);
	
	half_adder ha70(.a(m43), .b(m34), .s(s7), .c(c7));
	
	// 8
	and(m44, a[4], b[4]);
	
	assign s32 = m30;
	assign s0 = m00;
	assign s8 = m44;
	
	
	stage2 st2(.s0(s0), .s1(s1),	.s2(s2), .s3(s3), .s4(s4), .s5(s5), .s6(s6), .s7(s7), .s8(s8), .s32(s32), .s42(s42), .s52(s52), .c1(c1), .c2(c2), .c3(c3), .c4(c4), .c5(c5), .c6(c6), .c7(c7),.c52(c52), .result(result), .overflow(overflow));
	
endmodule	