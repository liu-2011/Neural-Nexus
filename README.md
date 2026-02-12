# Neural-Nexus NPU Accelerator

**Neural-Nexus** is a high-performance, RISC-V compatible graphics accelerator unit designed for efficient 2D image processing. This core implements hardware-accelerated Alpha Blending using SIMD (Single Instruction, Multiple Data) architecture.

## Key Features
- **Precision Arithmetic**: Implements the perfect rounding formula `(x + (x>>8)) >> 8` for 8-bit blending.
- **SIMD Architecture**: Processes 4 pixels (32-bit packed) per clock cycle.
- **Verification**: Includes full testbenches with self-checking logic.
- **Software Model**: Bit-accurate software emulation in C and PowerShell.

## Directory Structure
- `rtl/`: Verilog source code (Core & SIMD wrapper).
- `tb/`: Testbenches and simulation scripts.
- `docs/`: ISA specifications and architecture definitions.
- `sw/`: Software simulators and image generation tools.

## ISA Specification
**Instruction**: `NN.BLEND` (Opcode: `1111011`)
rd[i] = (rs1[i] * mask + rs2[i] * (255-mask) + 128) >> 8;

## License
MIT License. Copyright (c) 2026 Liu Mo.