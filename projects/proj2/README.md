# full ALU

## opcode

- get `op_xxx' by and gates to represent every opcode situation
- then assign `data_result` by this `op_xxx`
- Code:

```verilog
assign data_result = (op_xxx) xxx_result: data_result;
```



## SLL

> Logic

- we shift 1 bit for shiftamt[0]
- we shift 2 bit for shiftamt[1]
- we shift 4 bit for shiftamt[2]
- we shift 8 bit for shiftamt[3]
- we shift 16 bit for shiftamt[4]

## SRA

> Arithemtical

- the new bit in should be sign bit of operand

- we shift 1 bit for shiftamt[0]
- we shift 2 bit for shiftamt[1]
- we shift 4 bit for shiftamt[2]
- we shift 8 bit for shiftamt[3]
- we shift 16 bit for shiftamt[4]

