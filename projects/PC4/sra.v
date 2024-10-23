//arithmetical
module sra(data, shamt, result);

	input [31:0] data;
	input [4:0] shamt;
	output [31:0] result;
	
	wire [31:0] result_0,
					result_1,
					result_2,
					result_3;
	
	genvar i;
	
	//result_0
	generate
		for(i=0;i<31;i=i+1) begin: sra_0
			assign result_0[i] = (shamt[0])? data[i+1]: data[i];
		end
	endgenerate
	assign result_0[31] = (shamt[0])? data[31]: data[31];
	
	//result_1
	generate
		for(i=0;i<30;i=i+1) begin: sra_1
			assign result_1[i] = (shamt[1])? result_0[i+2]: result_0[i];
		end
	endgenerate
	assign result_1[30] = (shamt[1])? result_0[31]: result_0[30];
	assign result_1[31] = (shamt[1])? result_0[31]: result_0[31];
	
	//result_2
	generate
		for(i=0;i<28;i=i+1) begin: sra_2
			assign result_2[i] = (shamt[2])? result_1[i+4]: result_1[i];
		end
	endgenerate
	assign result_2[28] = (shamt[2])? result_1[31]: result_1[28];
	assign result_2[29] = (shamt[2])? result_1[31]: result_1[29];
	assign result_2[30] = (shamt[2])? result_1[31]: result_1[30];
	assign result_2[31] = (shamt[2])? result_1[31]: result_1[31];
	
	//result_3
	generate
		for(i=0;i<24;i=i+1) begin: sra_3
			assign result_3[i] = (shamt[3])? result_2[i+8]: result_2[i];
		end
	endgenerate
	
	generate
		for(i=24;i<32;i=i+1) begin: sra_3_0
			assign result_3[i] = (shamt[3])? result_2[31]: result_2[i];
		end
	endgenerate
	
	//result
	generate
		for(i=0;i<16;i=i+1) begin: sra_4
			assign result[i] = (shamt[4])? result_3[i+16]: result_3[i];
		end
	endgenerate
	
	generate
		for(i=16;i<32;i=i+1) begin: sra_4_0
			assign result[i] = (shamt[4])? result_3[31]: result_3[i];
		end
	endgenerate
	
	
	
	
endmodule