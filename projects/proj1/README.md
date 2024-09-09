# addsub-base

## design
- reuse the RCA_4b from lab before
- reuse it for both add and sub

## input
- for add, use the normal RCA calculation
- for sub, input ~B instead of B, and assign the cin by 1'b1

- code:
```verilog
// input depends on opcode
assign operandB = (ctrl_ALUopcode == 2'b00000)? data_operandB: ~data_operandB;
assign cin_now = (ctrl_ALUopcode == 2'b00000)? 1'b0: 1'b1;
```

## overflow
- overflow happens in ALU when:
  - for add:
    - pos + pos get a neg
    - neg + neg get a pos
  - for sub:
    - neg - pos get a pos
    - pos - neg get a neg
   
- so we get this truth table:

|opcode|A[31]|B[31]|ANS[31]|OF|
|---|---|---|---|---|
|0|0|0|1|1|
|0|1|1|0|1|
|1|1|0|0|1|
|1|0|1|1|1|

(others are when OF=0)

- so we can get gate circuit by this truth table, then use it to get overflow sign

- code:
```verilog
// add overflow
and(of_add0, ~data_operandA[31], ~data_operandB[31], add_result[31]);
and(of_add1, data_operandA[31], data_operandB[31], ~add_result[31]);
or(add_overflow, of_add0, of_add1);


// sub overflow
and(of_sub0, data_operandA[31], ~data_operandB[31], ~add_result[31]);
and(of_sub1, ~data_operandA[31], data_operandB[31], add_result[31]);
or(sub_overflow, of_sub0, of_sub1);

assign overflow = (ctrl_ALUopcode == 2'b00000)? add_overflow: sub_overflow; 
```
  
