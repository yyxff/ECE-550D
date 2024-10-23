module CSA_16b(a, b, cin, cout, s);
	//port
	input [15:0] a, b;
	input cin;
	output [15:0] s;
	output cout;
	
	//wires
	wire cout_c0, cout_c1, cout_low;
	wire [7:0] s_c0, s_c1;
	
	
	//high 0
	CSA_8b high_0(.a(a[15:8]), .b(b[15:8]), .cin(1'b0), .cout(cout_c0), .s(s_c0));
	
	//high 1
	CSA_8b high_1(.a(a[15:8]), .b(b[15:8]), .cin(1'b1), .cout(cout_c1), .s(s_c1));
	
	//low part
	CSA_8b low(.a(a[7:0]), .b(b[7:0]), .cin(cin), .cout(cout_low), .s(s[7:0]));
	
	
	//mux
	assign s[15:8] = (cout_low)? s_c1: s_c0;
	assign cout = (cout_low)? cout_c1: cout_c0;
	
endmodule