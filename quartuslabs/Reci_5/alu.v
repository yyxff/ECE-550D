module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;
	
	
	reg notEqual, less, of;
	assign isNotEqual = notEqual;
	assign isLessThan = less;
	assign overflow = of;
	
	reg [31:0] result;
	assign data_result = result;
	
	
	
	always @(data_operandA or data_operandB or ctrl_ALUopcode or ctrl_shiftamt) begin
	

		notEqual = 0;
		less = 0;
		of = 0;
		
		
		case (ctrl_ALUopcode)
			// add
			5'b00000: begin
				result = data_operandA + data_operandB;
				if ((data_operandA[31] == 0 && data_operandB[31] == 0 && result[31] != 0) || (data_operandA[31] != 0 && data_operandB[31] != 0 && result[31] == 0)) begin
					of = 1'b1;
				end
			end
			// sub
			5'b00001: begin
				result = data_operandA - data_operandB;
				if ((data_operandA[31] == 0 && data_operandB[31] != 0 && result[31] != 0) || (data_operandA[31] != 0 && data_operandB[31] == 0 && result[31] == 0)) begin
					of = 1'b1;
				end
				if (data_operandA != data_operandB) begin
					notEqual = 1'b1;
				end
				if (result[31] != 0) begin
					less = 1'b1;
				end
				if (of==1)begin
						less = ~less;
				end
			end
			// and
			5'b00010: begin
				result = data_operandA & data_operandB;
			end
			// or
			5'b00011: begin
				result = data_operandA | data_operandB;
			end
			// sll
			5'b00100: begin
				result = data_operandA << ctrl_shiftamt;
			end
			// sra
			5'b00101: begin
				result = data_operandA >>> ctrl_shiftamt;
			end
		
		endcase
		
		
		
			
	end
	

	

endmodule
