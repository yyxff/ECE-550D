module control(op, 
					func,
					op_r, 
					op_addi, 
					op_sw, 
					op_lw, 
					op_i,
					op_j, 
					op_bne, 
					op_jal, 
					op_jr, 
					op_blt, 
					op_bex, 
					op_setx,
					func_add, 
					func_sub,
					ctrl_writeEnable,
					wren,
					func_code);
	
	
	input [4:0] op, func;
//	input isNotEqual_m;
	
	// op and func type
	output wire op_r, op_addi, op_sw, op_lw, op_i, op_j, op_bne, op_jal, op_jr, op_blt, op_bex, op_setx, func_add, func_sub;
	output wire [4:0] func_code;
	
	// get write enable signals
	output wire ctrl_writeEnable, wren;
	
	// get all op type
	and(op_r, ~op[4], ~op[3], ~op[2], ~op[1], ~op[0]);
	and(op_addi, ~op[4], ~op[3], op[2], ~op[1], op[0]);
	and(op_sw, ~op[4], ~op[3], op[2], op[1], op[0]);
	and(op_lw, ~op[4], op[3], ~op[2], ~op[1], ~op[0]);
	and(op_j, ~op[4], ~op[3], ~op[2], ~op[1], op[0]);
	and(op_bne, ~op[4], ~op[3], ~op[2], op[1], ~op[0]);
	and(op_jal, ~op[4], ~op[3], ~op[2], op[1], op[0]);
	and(op_jr, ~op[4], ~op[3], op[2], ~op[1], ~op[0]);
	and(op_blt, ~op[4], ~op[3], op[2], op[1], ~op[0]);
	and(op_bex, op[4], ~op[3], op[2], op[1], ~op[0]);
	and(op_setx, op[4], ~op[3], op[2], ~op[1], op[0]);
	
	// get r i j type
	assign op_i = op_addi| op_lw| op_sw| op_bne| op_blt;
	assign op_j1 = op_j| op_jal| op_bex| op_setx;
	assign op_j2 = op_jr;
	
	// get all func code
	and(func_add, op_r, ~func[4], ~func[3], ~func[2], ~func[1], ~func[0]);
	and(func_sub, op_r, ~func[4], ~func[3], ~func[2], ~func[1], func[0]);

	// write enable signals
	or(ctrl_writeEnable, op_r, op_addi, op_lw);
	or(wren, op_sw,1'b0);
	
	// func_code
	assign func_code = (op_bne|op_blt)? 5'd1: (op_i)? {5{1'b0}}: func;
endmodule