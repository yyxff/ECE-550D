module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	wire wo0, wo1, wo2, wo3, wo4,wo5, wo6, wo10, wo11, wo12, wo13, wo14,wo15, wo16;
	wire [31:0] add_result, sub_result;
	wire add_overflow, sub_overflow;
	
	//add
	RCA_4b R0_a(.a(data_operandA[3:0]), .b(data_operandB[3:0]), .cin(1'b0), .cout(wo0), .s(add_result[3:0]));
	RCA_4b R1_a(.a(data_operandA[7:4]), .b(data_operandB[7:4]), .cin(wo0), .cout(wo1), .s(add_result[7:4]));
	RCA_4b R2_a(.a(data_operandA[11:8]), .b(data_operandB[11:8]), .cin(wo1), .cout(wo2), .s(add_result[11:8]));
	RCA_4b R3_a(.a(data_operandA[15:12]), .b(data_operandB[15:12]), .cin(wo2), .cout(wo3), .s(add_result[15:12]));
	RCA_4b R4_a(.a(data_operandA[19:16]), .b(data_operandB[19:16]), .cin(wo3), .cout(wo4), .s(add_result[19:16]));
	RCA_4b R5_a(.a(data_operandA[23:20]), .b(data_operandB[23:20]), .cin(wo4), .cout(wo5), .s(add_result[23:20]));
	RCA_4b R6_a(.a(data_operandA[27:24]), .b(data_operandB[27:24]), .cin(wo5), .cout(wo6), .s(add_result[27:24]));
	RCA_4b R7_a(.a(data_operandA[31:28]), .b(data_operandB[31:28]), .cin(wo6), .cout(add_overflow), .s(add_result[31:28]));
	
	//sub
	RCA_4b R0_s(.a(data_operandA[3:0]), .b(~data_operandB[3:0]), .cin(1'b1), .cout(wo10), .s(sub_result[3:0]));
	RCA_4b R1_s(.a(data_operandA[7:4]), .b(~data_operandB[7:4]), .cin(wo10), .cout(wo11), .s(sub_result[7:4]));
	RCA_4b R2_s(.a(data_operandA[11:8]), .b(~data_operandB[11:8]), .cin(wo11), .cout(wo12), .s(sub_result[11:8]));
	RCA_4b R3_s(.a(data_operandA[15:12]), .b(~data_operandB[15:12]), .cin(wo12), .cout(wo13), .s(sub_result[15:12]));
	RCA_4b R4_s(.a(data_operandA[19:16]), .b(~data_operandB[19:16]), .cin(wo13), .cout(wo14), .s(sub_result[19:16]));
	RCA_4b R5_s(.a(data_operandA[23:20]), .b(~data_operandB[23:20]), .cin(wo14), .cout(wo15), .s(sub_result[23:20]));
	RCA_4b R6_s(.a(data_operandA[27:24]), .b(~data_operandB[27:24]), .cin(wo15), .cout(wo16), .s(sub_result[27:24]));
	RCA_4b R7_s(.a(data_operandA[31:28]), .b(~data_operandB[31:28]), .cin(wo16), .cout(sub_overflow), .s(sub_result[31:28]));
	
	assign data_result = (ctrl_ALUopcode == 2'b00000)? add_result: sub_result;
	assign overflow = (ctrl_ALUopcode == 2'b00000)? add_overflow: sub_overflow;
endmodule
