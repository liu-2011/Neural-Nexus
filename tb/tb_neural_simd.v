`timescale 1ns / 1ps
module tb_neural_simd;
    reg clk, rst_n;
    reg [1:0]  mode;
    reg [31:0] rs1, rs2, param;
    wire [31:0] rd;
    neural_simd u_simd (
        .clk(clk), .rst_n(rst_n), .mode(mode),
        .rs1(rs1), .rs2(rs2), .param(param), .rd(rd)
    );
    always #10 clk = ~clk;
    initial begin
        $dumpfile("neural_simd_v2.vcd"); $dumpvars(0, tb_neural_simd);
        $display("Time | Mode |   RS1    |   Param  |    RD    | Note");
        $display("-------------------------------------------------------");
        clk=0; rst_n=0; mode=0; rs1=0; rs2=0; param=0;
        #20 rst_n=1;
        // Test 1: Blend (Mode 00)
        // RS1=100(0x64), RS2=200(0xC8), Param=128(0x80) -> Expect 150(0x96)
        #20 mode=0; rs1=32'h64646464; rs2=32'hC8C8C8C8; param=32'h80808080;
        // Test 2: Invert (Mode 01)
        // RS1=0x00_FF_64_C8 (0, 255, 100, 200)
        // Exp=0xFF_00_9B_37 (255, 0, 155, 55)
        #20 mode=1; rs1=32'h00FF64C8;
        // Test 3: Brightness (Mode 10) - Saturation Check
        // RS1=200(0xC8)
        // Param=100(0x64) -> 200+100=300 -> Clamp to 255 (0xFF)
        // Param=10 (0x0A) -> 200+10 =210 (0xD2)
        #20 mode=2; rs1=32'hC8C8C8C8; param=32'h640A640A; 
        #50 $finish;
    end
    always @(posedge clk) if(rst_n) #1 
        $display("%4t |  %b  | %h | %h | %h | Check!", $time, mode, rs1, param, rd);
endmodule
