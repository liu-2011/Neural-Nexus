# Neural-Nexus NPU Accelerator (v2.0)
**Neural-Nexus** is a high-performance, RISC-V compatible graphics accelerator unit designed for efficient 2D image processing. 
## Key Features
- **Multi-Function ALU**: Supports Blend, Invert, and Brightness modes.
- **Saturation Arithmetic**: Hardware-level clamping prevents overflow artifacts in brightness adjustment.
- **Precision Blending**: Implements the perfect rounding formula `(x + (x>>8)) >> 8`.
- **SIMD Architecture**: Processes 4 pixels (32-bit packed) per clock cycle.
## Supported Operations (Modes)
| Mode | Operation | Formula | Note |
| :-- | :--- | :--- | :--- |
| `00` | **Blend** | `A*M + B*(1-M)` | Alpha Blending with rounding |
| `01` | **Invert** | `255 - A` | Negative / X-Ray effect |
| `10` | **Bright** | `Min(A + V, 255)` | Brightness with Saturation |
## Directory Structure
- `rtl/`: Verilog source code (Core & SIMD wrapper).
- `tb/`: Testbenches and simulation scripts.
- `docs/`: ISA specifications.
- `sw/`: Software simulators.
## License
MIT License. Copyright (c) 2026 Liu Mo.
