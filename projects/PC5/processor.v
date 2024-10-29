/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	 
	 
	 // get all opcode
	 wire [4:0] op, func;
	 assign op = q_imem[31:27];
	 assign func = q_imem[6:2];
	 
	 // get all op signal
	 wire op_r, op_addi, op_sw, op_lw, op_i, op_j, op_bne, op_jal, op_jr, op_blt, op_bex, op_setx, op_j1;
	 // get all func signal
	 wire func_add, func_sub, func_and, func_or, func_sll, func_sra;
	 wire [4:0] func_code;
	 
	 // control circuit
	 control my_control(op,
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
							  op_j1,
							  ctrl_writeEnable,
							  wren,
							  func_code);

	 
	 
	 // main alu
	 // in wire
	 wire [31:0] operandB, sn_im;
	 wire isNotEqual_m, isLessThan_m, overflow_m;
	 wire [16:0] im;
	 
	 
	 // out wire
	 wire [31:0] alu_result,calcu_result;
	 
	 // in
	 assign im = q_imem[16:0];
	 assign sn_im = {{15{im[16]}}, im};
	 
	 assign operandB = (op_r|op_bne|op_blt|op_bex)? data_readRegB: 
							 (op_i)? sn_im:32'hzzzzzzzz;
							 
							 
							 
	 // out
	 assign calcu_result = (overflow_m & func_add)? 32'd1:
									(overflow_m & op_addi)? 32'd2:
									(overflow_m & func_sub)? 32'd3:alu_result;
									
	 
	 
	 assign address_dmem = calcu_result[11:0];
	 
	 assign data = data_readRegB;
							 
	 alu alu_main(.data_operandA(data_readRegA), 
						.data_operandB(operandB), 
						.ctrl_ALUopcode(func_code),
						.ctrl_shiftamt(q_imem[11:7]), 
						.data_result(alu_result), 
						.isNotEqual(isNotEqual_m), 
						.isLessThan(isLessThan_m), 
						.overflow(overflow_m)
						);
						
	 
	 
	 
	 
	 
	 
					
					
	 // connect regfile
	 assign ctrl_writeReg = (op_jal)? 5'd31: (op_setx|(overflow_m & (func_add | func_sub | op_addi)))? 5'd30:q_imem[26:22];
	 assign ctrl_readRegA = (op_bex)? 5'd0: q_imem[21:17];
	 assign ctrl_readRegB = (op_bex)? 5'd30: (op_sw|op_bne|op_blt)? q_imem[26:22]:q_imem[16:12];
	 
	 
	 // PC reg
	 wire [31:0] next_PC,normal_next_PC,b_next_PC,nb_next_PC;
	 wire [31:0] current_PC;
	 assign address_imem = current_PC[11:0];
	 dffe_ref PC(.q(current_PC),
					.d(next_PC),
					.clk(clock),
					.en(1'b1),
					.clr(reset)
					);
	 // PC alu
	 wire isNotEqual_PC, isLessThan_PC, overflow_PC;
	 alu alu_PC(.data_operandA(current_PC), 
					.data_operandB(32'd1), 
					.ctrl_ALUopcode(5'd0),
					.ctrl_shiftamt(5'd0), 
					.data_result(normal_next_PC), 
					.isNotEqual(isNotEqual_PC), 
					.isLessThan(isLessThan_PC), 
					.overflow(overflow_PC)
					);
					
	 // b alu
	 wire isNotEqual_b, isLessThan_b, overflow_b;
	 alu alu_b(.data_operandA(normal_next_PC), 
					.data_operandB(sn_im), 
					.ctrl_ALUopcode(5'd0),
					.ctrl_shiftamt(5'd0), 
					.data_result(b_next_PC), 
					.isNotEqual(isNotEqual_b), 
					.isLessThan(isLessThan_b), 
					.overflow(overflow_b)
					);
					
	// get real next PC
	wire jump_b;
	assign nb_next_PC = (jump_b)? b_next_PC: normal_next_PC;
	assign jump_b = (op_bne & isNotEqual_m) | (op_blt & isLessThan_m);
	
	
	//j1
	wire [26:0] j_im;
	wire jump_j1;
	assign j_im = q_imem[26:0];
	assign next_PC = (jump_j1)? {nb_next_PC[31:27], j_im}: nb_next_PC;
	assign jump_j1 = op_j|op_jal|op_bex;
	
	// alu main
	assign data_writeReg = (op_setx)? {5'd0,j_im}: (op_jal)? normal_next_PC: (op_lw)? q_dmem:calcu_result;
	
endmodule