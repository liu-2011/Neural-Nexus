module neural_simd (
    input  wire         clk,
    input  wire         rst_n,
    input  wire [31:0]  rs1,    // ????? 1 (???, ?? 4 ???)
    input  wire [31:0]  rs2,    // ????? 2 (???, ?? 4 ???)
    input  wire [31:0]  mask,   // ????? (?? 4 ???????)
    output wire [31:0]  rd      // ????? (?? 4 ?????)
);
    // ??? 32 ????? 4 ? 8 ????????? 4 ???
    // ??????? "???" ??
    // Core 0 (?? [7:0])
    neural_core core0 (
        .clk(clk), .rst_n(rst_n),
        .pixel_t(rs1[7:0]), .pixel_t1(rs2[7:0]), .mask(mask[7:0]),
        .pixel_out(rd[7:0])
    );
    // Core 1 (?? [15:8])
    neural_core core1 (
        .clk(clk), .rst_n(rst_n),
        .pixel_t(rs1[15:8]), .pixel_t1(rs2[15:8]), .mask(mask[15:8]),
        .pixel_out(rd[15:8])
    );
    // Core 2 (?? [23:16])
    neural_core core2 (
        .clk(clk), .rst_n(rst_n),
        .pixel_t(rs1[23:16]), .pixel_t1(rs2[23:16]), .mask(mask[23:16]),
        .pixel_out(rd[23:16])
    );
    // Core 3 (?? [31:24])
    neural_core core3 (
        .clk(clk), .rst_n(rst_n),
        .pixel_t(rs1[31:24]), .pixel_t1(rs2[31:24]), .mask(mask[31:24]),
        .pixel_out(rd[31:24])
    );
endmodule
