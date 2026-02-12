module neural_core (
    input  wire         clk,
    input  wire         rst_n,
    input  wire [7:0]   pixel_t,
    input  wire [7:0]   pixel_t1,
    input  wire [7:0]   mask,
    output reg  [7:0]   pixel_out
);
    wire [15:0] term_a;
    wire [15:0] term_b;
    wire [15:0] sum;
    wire [7:0]  inv_mask;
    // ??????????????
    wire [15:0] sum_rounded;
    wire [15:0] sum_adjusted;
    assign inv_mask = 8'd255 - mask;
    assign term_a = pixel_t * mask;
    assign term_b = pixel_t1 * inv_mask;
    assign sum = term_a + term_b;
    // --- ???? 255 ???? ---
    // 1. ???????? (+128)
    assign sum_rounded = sum + 16'd128;
    // 2. ????: (x + (x>>8)) >> 8 
    assign sum_adjusted = (sum_rounded + (sum_rounded >> 8));
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pixel_out <= 8'b0;
        end else begin
            // ????
            pixel_out <= sum_adjusted[15:8];
        end
    end
endmodule
