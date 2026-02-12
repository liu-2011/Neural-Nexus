module neural_core (
    input  wire         clk,
    input  wire         rst_n,
    input  wire [1:0]   mode,       // 00:Blend, 01:Invert, 10:Brightness
    input  wire [7:0]   pixel_t,    // ????
    input  wire [7:0]   pixel_t1,   // ???? (? Blend ?)
    input  wire [7:0]   param,      // ?? (Blend??Mask, Brightness?????)
    output reg  [7:0]   pixel_out
);
    // --- Mode 0: Blend Logic ---
    wire [15:0] term_a, term_b, sum_blend;
    wire [15:0] sum_rounded, blend_res;
    wire [7:0]  inv_mask;
    assign inv_mask = 8'd255 - param;
    assign term_a   = pixel_t * param;
    assign term_b   = pixel_t1 * inv_mask;
    assign sum_blend = term_a + term_b;
    assign sum_rounded = sum_blend + 16'd128;
    assign blend_res = (sum_rounded + (sum_rounded >> 8)) >> 8;
    // --- Mode 1: Invert Logic (????) ---
    wire [7:0] invert_res;
    assign invert_res = 8'd255 - pixel_t;
    // --- Mode 2: Brightness Logic (????) ---
    wire [8:0] bright_sum; // 9-bit ?????
    wire [7:0] bright_res;
    assign bright_sum = pixel_t + param;
    // ????: ???? 255 (Bit 8 ? 1)????? 255?????? 8 ?
    assign bright_res = (bright_sum[8]) ? 8'd255 : bright_sum[7:0];
    // --- ????? (Mux) ---
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pixel_out <= 8'b0;
        end else begin
            case (mode)
                2'b00: pixel_out <= blend_res[7:0];     // Blend
                2'b01: pixel_out <= invert_res;         // Invert
                2'b10: pixel_out <= bright_res;         // Brightness
                default: pixel_out <= pixel_t;          // Bypass (??)
            endcase
        end
    end
endmodule
