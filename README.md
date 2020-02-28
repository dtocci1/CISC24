# CISC24

## Machine Requirements
- Complete ALU
- RAM register file with 8 24-bit words
- Program counter
- Instruction memory
- Data memory (mimimum of 1kB by 24bit)
- Instruction decoder

## Report Requirements
- CISC24 RTL block level diagram (initial and final)
- VHDL coomponent specification and schematic design
- VHDL system specification and resulting schematic design
- Test plan design and test bench code
- Hardware test procedure and results used to verify
- Simulation results from test bench
- Schematic and UCF file for CISC24 machine

## Instruction Set
- **HALT**
- **CLR** SrcA
- **INC** SrcA
- **DEC** SrcA
- **NEG** SrcA
- **SLL** SrcA, IMMED
- **SRL** SrcA, IMMED
- **MVS** SrcA, SrcB
- **MVMI** MemA, SrcB
- **MSM** SrcA, MemB
- **ADD** SrcA, SrcB
- **SUB** SrcA, SrcB
- **MUL** SrcA, SrcB
- **DIV** SrcA, SrcB
- **AND** SrcA, SrcB
- **OR** SrcA, SrcB
- **XOR** SrcA, SrcB
- **ADDI** SrcA, IMMED
- **SUBI** SrcA, IMMED
