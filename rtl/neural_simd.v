module neural_simd (
    input  wire         clk,
    input  wire         rst_n,
    input  wire [1:0]   mode,   // ??????
    input  wire [31:0]  rs1,    // ?? 1 (???)
    input  wire [31:0]  rs2,    // ?? 2 (????, ? Blend ?)
    input  wire [31:0]  param,  // ?? (Mask ? Brightness Value)
    output wire [31:0]  rd      // ??
);
    // ??? 4 ? V2.0 ??
    neural_core core0 (.clk(clk), .rst_n(rst_n), .mode(mode),
        .pixel_t(rs1[7:0]), .pixel_t1(rs2[7:0]), .param(param[7:0]), .pixel_out(rd[7:0]));
    neural_core core1 (.clk(clk), .rst_n(rst_n), .mode(mode),
        .pixel_t(rs1[15:8]), .pixel_t1(rs2[15:8]), .param(param[15:8]), .pixel_out(rd[15:8]));
    neural_core core2 (.clk(clk), .rst_n(rst_n), .mode(mode),
        .pixel_t(rs1[23:16]), .pixel_t1(rs2[23:16]), .param(param[23:16]), .pixel_out(rd[23:16]));
    neural_core core3 (.clk(clk), .rst_n(rst_n), .mode(mode),
        .pixel_t(rs1[31:24]), .pixel_t1(rs2[31:24]), .param(param[31:24]), .pixel_out(rd[31:24]));
endmodule
