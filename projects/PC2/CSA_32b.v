module CSA_32b(a, b, cin, cout, s);
	//port
	input [31:0] a, b;
	input cin;
	output [31:0] s;
	output cout;
	
	//wires
	wire cout_c0, cout_c1, cout_low;
	wire [15:0] s_c0, s_c1;
	
	
	//high 0
	CSA_16b high_0(.a(a[31:16]), .b(b[31:16]), .cin(1'b0), .cout(cout_c0), .s(s_c0));
	
	//high 1
	CSA_16b high_1(.a(a[31:16]), .b(b[31:16]), .cin(1'b1), .cout(cout_c1), .s(s_c1));
	
	//low part
	CSA_16b low(.a(a[15:0]), .b(b[15:0]), .cin(cin), .cout(cout_low), .s(s[15:0]));
	
	
	//mux
	assign s[31:16] = (cout_low)? s_c1: s_c0;
	assign cout = (cout_low)? cout_c1: cout_c0;
	
endmodule