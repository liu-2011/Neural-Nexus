`timescale 1ns / 1ps
module tb_neural_simd;
    reg clk;
    reg rst_n;
    reg [31:0] rs1;
    reg [31:0] rs2;
    reg [31:0] mask;
    wire [31:0] rd;
    // ??? SIMD ??
    neural_simd u_simd (
        .clk(clk), .rst_n(rst_n),
        .rs1(rs1), .rs2(rs2), .mask(mask), .rd(rd)
    );
    always #10 clk = ~clk;
    initial begin
        $dumpfile("neural_simd.vcd");
        $dumpvars(0, tb_neural_simd);
        $display("Time |     RS1    |     RS2    |    Mask    |     RD     | Note");
        $display("----------------------------------------------------------------");
        clk = 0; rst_n = 0; rs1 = 0; rs2 = 0; mask = 0;
        #20 rst_n = 1;
        // ????: ????
        // RS1 (??) : 0x64646464 (?????? 100)
        // RS2 (??) : 0xC8C8C8C8 (?????? 200)
        // Mask       : 0x808000FF (??, ??, ??, ??)
        //              - Byte 3 (80=128): 50% ?? -> ?? 150 (0x96)
        //              - Byte 2 (80=128): 50% ?? -> ?? 150 (0x96)
        //              - Byte 1 (00=0)  : ???? -> ?? 200 (0xC8)
        //              - Byte 0 (FF=255): ???? -> ?? 100 (0x64)
        // ?? RD    : 0x9696C864
        #20 rs1 = 32'h64646464; rs2 = 32'hC8C8C8C8; mask = 32'h808000FF;
        #50 $finish;
    end
    always @(posedge clk) begin
        if (rst_n) #1 $display("%4t | %h | %h | %h | %h | Check 4 bytes!", $time, rs1, rs2, mask, rd);
    end
endmodule
