`timescale 1ns / 1ps
module tb_neural_core;
    reg clk;
    reg rst_n;
    reg [7:0] pixel_t;
    reg [7:0] pixel_t1;
    reg [7:0] mask;
    wire [7:0] pixel_out;
    neural_core u_neural_core (
        .clk(clk), .rst_n(rst_n), .pixel_t(pixel_t),
        .pixel_t1(pixel_t1), .mask(mask), .pixel_out(pixel_out)
    );
    always #10 clk = ~clk;
    initial begin
        $dumpfile("neural_nexus.vcd");
        $dumpvars(0, tb_neural_core);
        $display("Time | P_t | P_t1 | Mask | Out | Expected");
        $display("----------------------------------------------");
        clk = 0; rst_n = 0; pixel_t = 0; pixel_t1 = 0; mask = 0;
        #20 rst_n = 1;
        // Test 1: Mask=0 (Show P_t1) -> Exp: 200
        #20 pixel_t = 100; pixel_t1 = 200; mask = 0;
        // Test 2: Mask=255 (Show P_t) -> Exp: 100
        #20 pixel_t = 100; pixel_t1 = 200; mask = 255;
        // Test 3: Mask=128 (Mix) -> Exp: ~150
        #20 pixel_t = 100; pixel_t1 = 200; mask = 128;
        #50 $finish;
    end
    always @(posedge clk) begin
        if (rst_n) #1 $display("%4t | %3d | %3d  | %3d  | %3d | (Check Logic)", $time, pixel_t, pixel_t1, mask, pixel_out);
    end
endmodule
