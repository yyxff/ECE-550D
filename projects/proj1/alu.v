module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	wire wo0, wo1, wo2, wo3, wo4,wo5, wo6;
	
	//add
	RCA_4b R0(.a(data_operandA[3:0]), .b(data_operandB[3:0]), .cin(1'b0), .cout(wo0), .s(data_result[3:0]));
	RCA_4b R1(.a(data_operandA[7:4]), .b(data_operandB[7:4]), .cin(wo0), .cout(wo1), .s(data_result[7:4]));
	RCA_4b R2(.a(data_operandA[11:8]), .b(data_operandB[11:8]), .cin(wo1), .cout(wo2), .s(data_result[11:8]));
	RCA_4b R3(.a(data_operandA[15:12]), .b(data_operandB[15:12]), .cin(wo2), .cout(wo3), .s(data_result[15:12]));
	RCA_4b R4(.a(data_operandA[19:16]), .b(data_operandB[19:16]), .cin(wo3), .cout(wo4), .s(data_result[19:16]));
	RCA_4b R5(.a(data_operandA[23:20]), .b(data_operandB[23:20]), .cin(wo4), .cout(wo5), .s(data_result[23:20]));
	RCA_4b R6(.a(data_operandA[27:24]), .b(data_operandB[27:24]), .cin(wo5), .cout(wo6), .s(data_result[27:24]));
	RCA_4b R7(.a(data_operandA[31:28]), .b(data_operandB[31:28]), .cin(wo6), .cout(overflow), .s(data_result[31:28]));
	
endmodule
