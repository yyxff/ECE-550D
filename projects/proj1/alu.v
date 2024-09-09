module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	
	
	// use same RCA
	
	//carry in and out
	wire wo0, wo1, wo2, wo3, wo4,wo5, wo6, wo7;
	// result
	wire [31:0] add_result;
	// overfloe sign
	wire add_overflow, sub_overflow;
	// operandB into RCA
	wire [31:0] operandB;
	// temp wire to calculate overflow
	wire of_add0, of_add1, of_sub0, of_sub1;
	
	
	// input depends on opcode
	assign operandB = (ctrl_ALUopcode == 2'b00000)? data_operandB: ~data_operandB;
	assign cin_now = (ctrl_ALUopcode == 2'b00000)? 1'b0: 1'b1;
	
	
	// RCA
	RCA_4b R0_a(.a(data_operandA[3:0]), .b(operandB[3:0]), .cin(cin_now), .cout(wo0), .s(add_result[3:0]));
	RCA_4b R1_a(.a(data_operandA[7:4]), .b(operandB[7:4]), .cin(wo0), .cout(wo1), .s(add_result[7:4]));
	RCA_4b R2_a(.a(data_operandA[11:8]), .b(operandB[11:8]), .cin(wo1), .cout(wo2), .s(add_result[11:8]));
	RCA_4b R3_a(.a(data_operandA[15:12]), .b(operandB[15:12]), .cin(wo2), .cout(wo3), .s(add_result[15:12]));
	RCA_4b R4_a(.a(data_operandA[19:16]), .b(operandB[19:16]), .cin(wo3), .cout(wo4), .s(add_result[19:16]));
	RCA_4b R5_a(.a(data_operandA[23:20]), .b(operandB[23:20]), .cin(wo4), .cout(wo5), .s(add_result[23:20]));
	RCA_4b R6_a(.a(data_operandA[27:24]), .b(operandB[27:24]), .cin(wo5), .cout(wo6), .s(add_result[27:24]));
	RCA_4b R7_a(.a(data_operandA[31:28]), .b(operandB[31:28]), .cin(wo6), .cout(wo7), .s(add_result[31:28]));
	
	
	// add overflow
	and(of_add0, ~data_operandA[31], ~data_operandB[31], add_result[31]);
	and(of_add1, data_operandA[31], data_operandB[31], ~add_result[31]);
	or(add_overflow, of_add0, of_add1);
	
	
	// sub overflow
	and(of_sub0, data_operandA[31], ~data_operandB[31], ~add_result[31]);
	and(of_sub1, ~data_operandA[31], data_operandB[31], add_result[31]);
	or(sub_overflow, of_sub0, of_sub1);
	
	
	// result
	assign data_result = add_result;
	assign overflow = (ctrl_ALUopcode == 2'b00000)? add_overflow: sub_overflow; 
	
endmodule
