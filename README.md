# Riscv-Processor

This repository contains only the processor, no compiler or test bench.
This is my internship project that I built in summer 2019. It is a basic riscv core with all the formats of instruction implemented(Only most used instructions of all formats were implemented). It is pipelined but only data hazard is removed among pipelined hazards.
I have built all modules from scratch except rom(IMEM), data memory and comparator(pipelined). In case of these modules, I have used pre made board specific modules from altera LPM library.

It has following instructions implemented and tested:
R-format:
  add
  sub
  sll
  srl
  sra
  slt
  or
  and
  
I-format:
  addi
  slli
  slti
  srli
  srai
  ori
  andi
  lw
  jalr
  
S-format:
  sw
  
SB-format:
  breq
  brne
  brlt
  bge
  
U-format:
  lui
  
UJ-format:
  jal
Mult extension:
  mulh
