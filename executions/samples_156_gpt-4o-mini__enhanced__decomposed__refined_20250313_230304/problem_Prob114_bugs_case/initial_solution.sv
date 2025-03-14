```verilog
[BEGIN]
module TopModule (
    input  logic [7:0] code,       // 8-bit input representing keyboard scancode
    input  logic clk,               // Clock signal for synchronous reset
    input  logic rst_n,             // Active low reset signal
    output logic [3:0] out,        // 4-bit output representing detected key (0-9)
    output logic valid              // 1-bit output indicating valid detection
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out   <= 4'b0000; // Default to '0'
        valid <= 1'b0;    // Default to 'invalid'
    end else begin
        // Initialize outputs to default state
        out   = 4'b0000; // Default to '0'
        valid = 1'b0;    // Default to 'invalid'

        // Recognize valid scancodes
        case (code)
            8'h45: begin out = 4'b0000; valid = 1'b1; end // 0
            8'h16: begin out = 4'b0001; valid = 1'b1; end // 1
            8'h1e: begin out = 4'b0010; valid = 1'b1; end // 2
            8'h26: begin out = 4'b0011; valid = 1'b1; end // 3
            8'h25: begin out = 4'b0100; valid = 1'b1; end // 4
            8'h2e: begin out = 4'b0101; valid = 1'b1; end // 5
            8'h36: begin out = 4'b0110; valid = 1'b1; end // 6
            8'h3d: begin out = 4'b0111; valid = 1'b1; end // 7
            8'h3e: begin out = 4'b1000; valid = 1'b1; end // 8
            8'h46: begin out = 4'b1001; valid = 1'b1; end // 9
            default: begin out = 4'b0000; valid = 1'b0; end // Invalid input case
        endcase
    end
end

endmodule
[DONE]
```