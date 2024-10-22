// You need to generate this component correctly
module imem(
        address,            // address of data
        clock,                  // you may need to invert the clock
        q                   // the raw instruction
    );
	
	input [11:0] address;
	input clock;
	output [31:0] q;
	
	
	wire [31:0] readData[4095:0];
	
	// connect every reg

	genvar i;
	generate 
		for (i=0;i<4096;i=i+1) begin: regs
			dffe_ref my_dffe(.q(readData[i]), 
								 .d(32'h00000000),
								 .clk(clock),
								 .en(0),
								 .clr(0)
								 );
		end
	endgenerate
	
	assign q = readData[address];

endmodule