# full ALU

## name: Yangfan Ye

## NetID: yy465

## modules

- `alu` top entity
  - `sll` for SLL op
  - `sra` for SRA op
  - `CSA_32b` for add/sub op
  - `CSA_16b` to contribute `CSA_32b`
  - `CSA_8b` to contribute `CSA_16b`
  - `RCA_4b` to contribute `CSA_8b`
  - `full_adder` to contribute `RCA_4b`

## opcode

- get `op_xxx` by and gates to represent every opcode situation
- then assign `data_result` by this `op_xxx`

### code:

```verilog
/*
opcode
*/
wire op_add, op_sub, op_and, op_or, op_sll, op_sra;
and(op_add, ~ctrl_ALUopcode[2], ~ctrl_ALUopcode[1], ~ctrl_ALUopcode[0]);//000
and(op_sub, ~ctrl_ALUopcode[2], ~ctrl_ALUopcode[1], ctrl_ALUopcode[0]);//001
and(op_and, ~ctrl_ALUopcode[2], ctrl_ALUopcode[1], ~ctrl_ALUopcode[0]);//010
and(op_or, ~ctrl_ALUopcode[2], ctrl_ALUopcode[1], ctrl_ALUopcode[0]);//011
and(op_sll, ctrl_ALUopcode[2], ~ctrl_ALUopcode[1], ~ctrl_ALUopcode[0]);//100
and(op_sra, ctrl_ALUopcode[2], ~ctrl_ALUopcode[1], ctrl_ALUopcode[0]);//101


/*
data_result
*/
assign data_result = (op_add)? cal_result:
                    (op_sub)? cal_result:
                    (op_and)? andAB:
                    (op_or)?  orAB: 
                    (op_sll)? sll_result: 
                    (op_sra)? sra_result: data_result;
```



## ports

### isNotEqual

> can we use `|A`?

- Use `or` gate to gather each bit of `sub_result`
  - if there is no 1, isNotEqual = 0
  - if there is at least one 1, isNotEqual = 1


### isLessThan

- we get it from the sub result
- so we need to consider `overflow`

- If `sub_result[31]` is 1 $\Rightarrow$ `isLessThan` is 1
  - Except: when `overflow` is 1
    - pos - neg = neg
      - get 1, should be 0
    - neg - pos = pos
      - get 0, should be 1
    - so we flip `isLessThan` when overflow

#### code:

```verilog
/*
isLessThan
*/
wire less;
assign less = (overflow)? ~data_result[31]: data_result[31];
assign isLessThan = (op_sub)? less: 1'b0;
```



## AND

- we use 32 `and` gates for crrosponding bits of operand A B
- do it by generate block

### code:

```verilog
/*
AND
*/

// wires
wire [31:0] andAB;

// and gates
generate
  for (i = 0; i<32;i=i+1) begin: get_AND
    and(andAB[i], data_operandA[i], data_operandB[i]);
  end
endgenerate
```



## OR

- we use 32 `or` gates for crrosponding bits of operand A B
- do it by generate block

### code:

```verilog
/*
OR
*/

// wires
wire [31:0] orAB;

// and gates
generate
  for (i = 0; i<32;i=i+1) begin: get_OR
    or(orAB[i], data_operandA[i], data_operandB[i]);
  end
endgenerate
```



## SLL

> Logic

- we shift 1 bit for shiftamt[0]
- we shift 2 bit for shiftamt[1]
- we shift 4 bit for shiftamt[2]
- we shift 8 bit for shiftamt[3]
- we shift 16 bit for shiftamt[4]

### code:

```verilog
//example for shiftamt[0]
// result_0
generate
  for(i=1;i<32;i=i+1) begin: sll_0
    assign result_0[i] = (shamt[0])? data[i-1]:data[i];
  end
endgenerate
assign result_0[0] = (shamt[0])? 1'b0: data[0];
```



## SRA

> Arithemtical

- the new bit in should be sign bit of operand
- we shift 1 bit for shiftamt[0]
- we shift 2 bit for shiftamt[1]
- we shift 4 bit for shiftamt[2]
- we shift 8 bit for shiftamt[3]
- we shift 16 bit for shiftamt[4]

### code:

```verilog
//example for shiftamt[0]
//result_0
generate
  for(i=0;i<31;i=i+1) begin: sra_0
    assign result_0[i] = (shamt[0])? data[i+1]: data[i];
  end
endgenerate
assign result_0[31] = (shamt[0])? data[31]: data[31];
```



