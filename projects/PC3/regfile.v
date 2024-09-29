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
	

	//reg clr;
	
	//32 32b wire
	wire [31:0] readData[31:0];
	
	genvar i;
	generate 
		for (i=0;i<32;i=i+1) begin: regs
			if (i>0) begin
				dffe_ref my_dffe(.q(readData[i]), 
								 .d(data_writeReg),
								 .clk(clock),
								 .en(ctrl_writeEnable),
								 .clr(ctrl_reset)
								 );
			end
			else begin
				dffe_ref my_dffe(.q(readData[i]), 
									 .d(32'h00000000),
									 .clk(clock),
									 .en(ctrl_writeEnable),
									 .clr(ctrl_reset)
									 );
			end
				
			
		end
	endgenerate
	
//	wire address_a0,address_b0;
//	and(address_a0,~ctrl_readRegA[4],~ctrl_readRegA[3],~ctrl_readRegA[2],~ctrl_readRegA[1],~ctrl_readRegA[0]);
//	and(address_b0,~ctrl_readRegB[4],~ctrl_readRegB[3],~ctrl_readRegB[2],~ctrl_readRegB[1],~ctrl_readRegB[0]);
	
	assign data_readRegA = readData[ctrl_readRegA];
	assign data_readRegB = readData[ctrl_readRegB];
	
	

endmodule
 