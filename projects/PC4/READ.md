# PC4 simple CPU

## name:
Yangfan Ye

Junyan Li

## netID:
yy465

jl1355

## modules:
- `skeleton`: top entity
- `imem`: instructions memory
- `dmem`: data memory
- `regfile`: register file
- `dffe`: 32b dff
- `processor`: entity to implement datapath of alu, regfile, imem and dmem 
- `alu`: alu entity
  - `CSA_32b`: 32b adder
  - `CSA_16b`: 16b adder
  - `CSA_8b`: 8b adder
  - `RCA_4b`: 4b adder
  - `full_adder`: 1b full adder
  - `sll`: sll function
  - `sra`: sra function
- `control`: control circuit of cpu
- `frequency_divider_by2`: generate different clock

## imem
- generated ROM
- 4096 x 32b
- one layer dff inside, so the data will be read out when next one clock

## dmem
- generated RAM
- 4096 x 32b
- one layer dff inside, so the data will be read out when next one clock

## regfile
- 32b regfile

## dffe
- 32b dff
- used in `PC` pointer

## processor
- entity to implement datapath of alu, regfile, imem and dmem and control circuit

## alu
- one instance of `alu_main`
  - use `operandB` to replace `data_operandB`, bacause operandB need to change to something else by control signal
- one instance of `alu_PC`
  - add 1 in this proj, because imem is 32b
  - need a dff to change `current_PC` to `next_PC`
 
## control
- input `op_code` and `func_code`, to generate different control signals for cpu
- the ouput signal will control the datapath of cpu
- for example:
  - we need to input immediate number for `addi`, instead of `$rt`
  - we need to write to `$rstatus` when overflow, instead of `$rd`

## frequency_divider_by2
- generate different clock
- for example:
  - to accomodate data memory reading and writing, we need two `dmem` clock in one `processor` clock 
  - `imem` clock shoule be same as `processor`
