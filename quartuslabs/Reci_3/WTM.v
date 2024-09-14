module WTM(a, b, result, c);
	input [4: 0] a, b;
	output [9: 0] result;
	output c;
	
	stage1 st1(.a(a), .b(b), .result(result), .overflow(c));

endmodule