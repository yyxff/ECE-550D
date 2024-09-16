# addsub-base

## name: Yangfan Ye  

## netID: yy465

## design
- use CSA_32b, build from RCA_4b
  - up to down
  - CSA_32b
  - CSA_16b
  - CSA_8b
  - RCA_4b
  - full_adder
- use only one of it for both add and sub
  - use mux to select b and notb
  - connect cin to ALUopcode
 
- wires design:
  - b, notb are used to calculate add or sub
  - cin_now, cout_now are used to calculate add or sub
  - add_overflow, sub_overflow, of_add* and of_sub* are used to calculate overflow
  

## input
- for add, use the normal CSA calculation
- for sub, input ~B instead of B, and assign the cin by 1'b1
- get notb by generate block

- code:
```verilog
// generate notb instead of many not gate statements
genvar i;
generate
  for (i = 0; i<32;i=i+1) begin: get_notb
  not(notb[i], data_operandB[i]);
  end
endgenerate

// input depends on opcode
assign b = (ctrl_ALUopcode == 2'b00000)? data_operandB: notb;
assign cin_now = (ctrl_ALUopcode == 2'b00000)? 1'b0: 1'b1;

// do add or sub by CSA_32b
CSA_32b csa(.a(data_operandA), .b(b), .cin(cin_now), .cout(cout_now), .s(data_result));
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
and(of_add0, nota31, notb[31], result[31]);
and(of_add1, data_operandA[31], data_operandB[31], notres31);
or(add_overflow, of_add0, of_add1);


// sub overflow
and(of_sub0, data_operandA[31], notb[31], notres31);
and(of_sub1, nota31, data_operandB[31], result[31]);
or(sub_overflow, of_sub0, of_sub1);

assign overflow = (ctrl_ALUopcode == 2'b00000)? add_overflow: sub_overflow; 
```
  
