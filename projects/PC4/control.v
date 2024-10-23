module control(op, 
					func,
					op_r, 
					op_addi, 
					op_sw, 
					op_lw, 
					op_i,
					func_add, 
					func_sub);
	
	
	input [4:0] op, func;
	
	output op_r, op_addi, op_sw, op_lw, op_i,func_add, func_sub;
	// get all op type
	wire op_r, op_addi, op_sw, op_lw, op_i;
	
	and(op_r, ~op[4], ~op[3], ~op[2], ~op[1], ~op[0]);
	and(op_addi, ~op[4], ~op[3], op[2], ~op[1], op[0]);
	and(op_sw, ~op[4], ~op[3], op[2], op[1], op[0]);
	and(op_lw, ~op[4], op[3], ~op[2], ~op[1], ~op[0]);
	or(op_i, op_addi, op_lw, op_sw);

	// get all func code
	wire func_add, func_sub, func_and, func_or, func_sll, func_sra;

	and(func_add, op_r, ~func[4], ~func[3], ~func[2], ~func[1], ~func[0]);
	and(func_sub, op_r, ~func[4], ~func[3], ~func[2], ~func[1], func[0]);
endmodule