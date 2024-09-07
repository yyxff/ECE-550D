module RCA_4b(a, b, cin, cout, s);
	input[3:0] a, b;
	input cin;
	output cout;
	output [3:0] s;
	wire w0, w1, w2;
	
	full_adder my_fa0(.a(a[0]), .b(b[0]), .cin(cin), .s(s[0]), .cout(w0));
	full_adder my_fa1(.a(a[1]), .b(b[1]), .cin(w0), .s(s[1]), .cout(w1));
	full_adder my_fa2(.a(a[2]), .b(b[2]), .cin(w1), .s(s[2]), .cout(w2));
	full_adder my_fa3(.a(a[3]), .b(b[3]), .cin(w2), .s(s[3]), .cout(cout));
	
endmodule