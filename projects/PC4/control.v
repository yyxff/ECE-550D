module control(op, 
					func,
					op_r, 
					op_addi, 
					op_sw, 
					op_lw, 
					op_i,
					func_add, 
					func_sub,
					ctrl_writeEnable,
					wren,
					func_code);
	
	
	input [4:0] op, func;
	
	// op and func type
	output wire op_r, op_addi, op_sw, op_lw, op_i,func_add, func_sub;
	output wire [4:0] func_code;
	
	// get write enable signals
	output wire ctrl_writeEnable, wren;
	
	// get all op type
//	wire op_r, op_addi, op_sw, op_lw, op_i;/
	
	and(op_r, ~op[4], ~op[3], ~op[2], ~op[1], ~op[0]);
	and(op_addi, ~op[4], ~op[3], op[2], ~op[1], op[0]);
	and(op_sw, ~op[4], ~op[3], op[2], op[1], op[0]);
	and(op_lw, ~op[4], op[3], ~op[2], ~op[1], ~op[0]);
	or(op_i, op_addi, op_lw, op_sw);

	// get all func code
//	wire func_add, func_sub, func_and, func_or, func_sll, func_sra;

	and(func_add, op_r, ~func[4], ~func[3], ~func[2], ~func[1], ~func[0]);
	and(func_sub, op_r, ~func[4], ~func[3], ~func[2], ~func[1], func[0]);
//	
	// write enable signals
	or(ctrl_writeEnable, op_r, op_addi, op_lw);
//	assign ctrl_writeEnable = (op_r)?
	
	or(wren, op_sw,1'b0);
	
	// func_code
	assign func_code = (op_i)? {5{1'b0}}: func;
endmodule