module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	
	
	// wires
	wire [31:0] b, result;
	// cin cout wire
	wire cin_now, cout_now;
	// wire to calculate overflow
	wire of_add0, of_add1, of_sub0, of_sub1;
	// overfloe sign
	wire add_overflow, sub_overflow;
	
	
	// input b if add, input notb if sub
	assign b = (ctrl_ALUopcode == 2'b00000)? data_operandB: ~data_operandB;
	// input cin = 0 if add, input cin = 1 if sub
	assign cin_now = (ctrl_ALUopcode == 2'b00000)? 1'b0:1'b1;
	
	// CSA_32b
	CSA_32b csa(.a(data_operandA), .b(b), .cin(cin_now), .cout(cout_now), .s(result));
	
	
	// check overflow 
	// add overflow
	and(of_add0, ~data_operandA[31], ~data_operandB[31], result[31]);
	and(of_add1, data_operandA[31], data_operandB[31], ~result[31]);
	or(add_overflow, of_add0, of_add1);
	
	// sub overflow
	and(of_sub0, data_operandA[31], ~data_operandB[31], ~result[31]);
	and(of_sub1, ~data_operandA[31], data_operandB[31], result[31]);
	or(sub_overflow, of_sub0, of_sub1);
	
	
	// result
	assign data_result = result;
	assign overflow = (ctrl_ALUopcode == 2'b00000)? add_overflow: sub_overflow; 
	
endmodule
