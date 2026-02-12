Neural-Nexus ISA v1.0

Instruction: NN.BLEND (Neural Blend)
Description: Performs 8-bit alpha blending on 4 packed pixels simultaneously.
Opcode: 1111011 (Custom-0)
Format: R-Type

Operation (Pseudocode):
for (i=0; i<4; i++) {
  rd[i] = (rs1[i] * mask + rs2[i] * (255-mask) + 128) >> 8;
}
