module CSA_8b(a, b, cin, cout, s);
	//port
	input [7:0] a, b;
	input cin;
	output [7:0] s;
	output cout;
	
	//wires
	wire [3:0] s_c0, s_c1;
	wire cout_c0, cout_c1, cout_low;
	
	
	//high part when cin=0
	RCA_4b add_rca(.a(a[7:4]), .b(b[7:4]), .cin(1'b0), .cout(cout_c0), .s(s_c0));
	
	//high part when cin=1
	RCA_4b sub_rca(.a(a[7:4]), .b(b[7:4]), .cin(1'b1), .cout(cout_c1), .s(s_c1));
	
	//low part
	RCA_4b low_rca(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(cout_low), .s(s[3:0]));
	
	//mux
	assign s[7:4] = (cout_low)? s_c1: s_c0;
	assign cout = (cout_low)? cout_c1: cout_c0;

	
endmodule