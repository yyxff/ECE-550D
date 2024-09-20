module sll(data, shamt, result);

	input [31:0] data;
	input [4:0] shamt;
	output [31:0] result;
	
	wire [31:0] result_0,
					result_1,
					result_2,
					result_3;
	
	genvar i;
	
	// result_0
	generate
		for(i=1;i<32;i=i+1) begin: sll_0
			assign result_0[i] = (shamt[0])? data[i-1]:data[i];
		end
	endgenerate
	assign result_0[0] = (shamt[0])? 1'b0: data[0];
	
	// result_1
	generate
		for(i=2;i<32;i=i+1) begin: sll_1
			assign result_1[i] = (shamt[1])? result_0[i-2]:result_0[i];
		end
	endgenerate
	assign result_1[0] = (shamt[1])? 1'b0: result_0[0];
	assign result_1[1] = (shamt[1])? 1'b0: result_0[1];
	
	// result_2
	generate
		for(i=4;i<32;i=i+1) begin: sll_2
			assign result_2[i] = (shamt[2])? result_1[i-4]:result_1[i];
		end
	endgenerate
	assign result_2[0] = (shamt[2])? 1'b0: result_1[0];
	assign result_2[1] = (shamt[2])? 1'b0: result_1[1];
	assign result_2[2] = (shamt[2])? 1'b0: result_1[2];
	assign result_2[3] = (shamt[2])? 1'b0: result_1[3];
	
	// result_3
	generate
		for(i=8;i<32;i=i+1) begin: sll_3
			assign result_3[i] = (shamt[3])? result_2[i-8]:result_2[i];
		end
	endgenerate
	
	generate
		for(i=0;i<8;i=i+1) begin: sll_3_0
			assign result_3[i] = (shamt[3])? 1'b0: result_2[i];
		end
	endgenerate
	
	// result_4
	generate
		for(i=16;i<32;i=i+1) begin: sll_4
			assign result[i] = (shamt[4])? result_3[i-16]:result_3[i];
		end
	endgenerate
	
	generate
		for(i=0;i<16;i=i+1) begin: sll_4_0
			assign result[i] = (shamt[4])? 1'b0: result_3[i];
		end
	endgenerate
	
endmodule