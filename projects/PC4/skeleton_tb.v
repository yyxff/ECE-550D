// ---------- SAMPLE TEST BENCH ----------
`timescale 1 ns / 100 ps
module skeleton_tb();
    // inputs to the DUT are reg type
    reg            clock, reset;

    // outputs from the DUT are wire type
    wire imem_clock, dmem_clock, processor_clock, regfile_clock;
	 wire [11:0] address_imem;
    wire [31:0] q_imem;
	 
	 wire ctrl_writeEnable;
    wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    wire [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;
	 
	 wire [11:0] address_dmem;
    wire [31:0] data;
    wire wren;
    wire [31:0] q_dmem;

    // Tracking the number of errors
    integer errors;
    integer index;    // for testing...

    // instantiate the DUT
    skeleton my_skeleton (clock, reset, imem_clock, dmem_clock, processor_clock, regfile_clock,
									address_imem,
									q_imem,
									ctrl_writeEnable,
									ctrl_writeReg, 
									ctrl_readRegA, 
									ctrl_readRegB,
									data_writeReg,
									data_readRegA, 
									data_readRegB,
									address_dmem,
									data,
									wren,
									q_dmem
									);

    // setting the initial values of all the reg
    initial
    begin
        $display($time, " << Starting the Simulation >>");
        clock = 1'b0;    // at time 0
        errors = 0;

        reset = 1'b1;    // assert reset

        @(negedge clock);    // wait until next negative edge of clock
//        @(negedge clock);    // wait until next negative edge of clock

        reset = 1'b0;    // de-assert reset
        @(negedge clock);    // wait until next negative edge of clock

		  // check init
		  $display("checking init");
		  
		  $display("reg $a %h, $b %h", data_readRegA, data_readRegB);
		  $display("reg $a %h, $b %h", data_readRegA, data_readRegB);
		  $display("reg $a %h, $b %h", data_readRegA, data_readRegB);
		  
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  @(negedge clock);
		  
		  

//		  reset = 1'b0; #10

        $stop;
    end



    // Clock generator
    always
         #10     clock = ~clock;    // toggle


endmodule
