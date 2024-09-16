module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	
	
	// wires
	wire [31:0] b, notb;
	// cin cout wire
	wire cin_now, cout_now;
	// wire to calculate overflow
	wire of_add0, of_add1, of_sub0, of_sub1;
	// overfloe sign
	wire add_overflow, sub_overflow;
	
	
	//used to calculate overflow
	wire nota31, notres31;
	not(nota31, data_operandA[31]);
	not(notres31, data_result[31]);
	
	// input b if add, input notb if sub
	// generate notb instead of many not gate statements
	genvar i;
	generate
		for (i = 0; i<32;i=i+1) begin: get_notb
			not(notb[i], data_operandB[i]);
		end
	endgenerate

	assign b = (ctrl_ALUopcode[0])? notb: data_operandB;
	
	
	// input cin = 0 if add, input cin = 1 if sub
	assign cin_now = (ctrl_ALUopcode[0])? 1'b1:1'b0;
	
	// do add or sub by CSA_32b
	CSA_32b csa(.a(data_operandA), .b(b), .cin(cin_now), .cout(cout_now), .s(data_result));
	
	
	// check overflow 
	// add overflow
	and(of_add0, nota31, notb[31], data_result[31]);
	and(of_add1, data_operandA[31], data_operandB[31], notres31);
	or(add_overflow, of_add0, of_add1);
	
	// sub overflow
	and(of_sub0, data_operandA[31], notb[31], notres31);
	and(of_sub1, nota31, data_operandB[31], data_result[31]);
	or(sub_overflow, of_sub0, of_sub1);
	
	
	// overflow result
	assign overflow = (ctrl_ALUopcode[0])? sub_overflow: add_overflow; 
	
endmodule
