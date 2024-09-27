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
	
//	wire [31:0] readData;
	reg clr;
	
	wire [31:0] readData[31:0];
	
	genvar i;
	generate 
		for (i=0;i<32;i=i+1) begin: regs
//			wire [31:0] readData;
			dffe_ref my_dffe(.q(readData[i]), 
							 .d(data_writeReg),
							 .clk(clock),
							 .en(ctrl_writeEnable),
							 .clr(clr)
							 );
				
			
		end
	endgenerate
	
	assign data_readRegA = readData[ctrl_readRegA];
	assign data_readRegB = readData[ctrl_readRegB];
	
	

endmodule
 