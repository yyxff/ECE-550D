module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;

   /* YOUR CODE HERE */
	

	
	//32 32b wire
	wire [31:0] readData[31:0];
	
	//32b decoded write address
	wire [31:0] dec_writeEnable;
	decoder_5to32 decoder(.enable(ctrl_writeEnable), .shamt(ctrl_writeReg), .result(dec_writeEnable));
	
	// connect every reg
	// reg0 should stay 0
	genvar i;
	generate 
		for (i=0;i<32;i=i+1) begin: regs
			if (i>0) begin
				dffe_ref my_dffe(.q(readData[i]), 
								 .d(data_writeReg),
								 .clk(clock),
								 .en(dec_writeEnable[i]),
								 .clr(ctrl_reset)
								 );
			end
			else begin
				dffe_ref my_dffe(.q(readData[i]), 
									 .d(32'h00000000),
									 .clk(clock),
									 .en(dec_writeEnable[i]),
									 .clr(ctrl_reset)
									 );
			end
				
			
		end
	endgenerate
	

	// read port
	assign data_readRegA = readData[ctrl_readRegA];
	assign data_readRegB = readData[ctrl_readRegB];
	
	

endmodule
 