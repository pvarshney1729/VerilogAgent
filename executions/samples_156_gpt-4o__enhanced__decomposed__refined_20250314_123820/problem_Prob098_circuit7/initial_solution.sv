[BEGIN]
module TopModule (
    input logic clk,  // Clock signal, positive edge-triggered
    input logic rst,  // Synchronous reset, active high
    input logic a,    // One-bit input
    output logic q    // One-bit output, registered
);

    always @(posedge clk) begin
        if (rst) begin
            q <= 1'b0;  // Reset state
        end else begin
            if (a) begin
                q <= 1'b0;  // Set q to 0 when a is 1
            end else begin
                q <= 1'b1;  // Maintain q as 1 when a is 0
            end
        end
    end

endmodule
[DONE]