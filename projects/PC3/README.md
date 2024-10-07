# PC3 regfile

## name: Yangfan Ye

## netid: yy465

## modules
- `dffe`: 32b register
- `regfile`: top entity
- `decoder`: 5 to 32 decoder to decode write address

## dffe
- every `dffe` is a 32 bits register(with beheaviral verilog)
  - input and output data is 32b
  - changed when every posedge of `clk`(clock) or `clr`(clear)
    - but truly assigned when this period ends
  - enabled when `en` is true

- code:
```verilog
always @(posedge clk or posedge clr) begin
       //If clear is high, set q to 0
       if (clr) begin
           q <= 0;
       //If enable is high, set q to the value of d
       end else if (en) begin
           q <= d;
       end
end
```
## regfile
- keep the reg0 as `32'h00000000` by connecting its input data to `32'h00000000`
  - rest of regs' input will be connected to `data_writeReg`
- use `readData`(32x32) to read every register's data
  - read them by different read address


- code:
```verilog
// make every reg instance and connect their ports
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


//32 32b wire
wire [31:0] readData[31:0];

assign data_readRegA = readData[ctrl_readRegA];
assign data_readRegB = readData[ctrl_readRegB];
```

## decoder
- use `sll` in PC2 to build decoder by mux
- input `ctrl_writeEnable`(1b) and `ctrl_writeReg`(5b), output `dec_writeEnable`(32b)
  - if `ctrl_writeEnable`is 0, output will be all 0
  - if `ctrl_writeEnable`is 1, we will left-shift `32'h00000001` by amount of `ctrl_writeReg`
  - in this way we only enabled the reg we selected by `ctrl_writeReg`, or enabled nothing if `ctrl_writeEnable` is 0
