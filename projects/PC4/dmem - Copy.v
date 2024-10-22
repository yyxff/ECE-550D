// You need to generate this component correctly
module dmem(
        address,       // address of data
        clock,                  // may need to invert the clock
        data,    // data you want to write
        wren,      // write enable
        q     // data from dmem
    );
	 
	 input [11:0] address;
	 input clock;
	 input [31:0] data;
	 input wren;
	 output [31:0] q;
	 
	 
	 wire [31:0] readData[4095:0];
	
	// connect every reg

	genvar i;
	generate 
		for (i=0;i<4096;i=i+1) begin: regs
			dffe_ref my_dffe(.q(readData[i]), 
								 .d(data),
								 .clk(clock),
								 .en(wren),
								 .clr(0)
								 );
		end
	endgenerate
	
	assign q = readData[address];
	 
endmodule