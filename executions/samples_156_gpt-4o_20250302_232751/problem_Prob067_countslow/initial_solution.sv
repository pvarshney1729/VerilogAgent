module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic reset,        // Synchronous active-high reset signal
    input logic slowena,      // Enable signal for counter increment
    output logic [3:0] q      // 4-bit output representing the counter value
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'd0;
        end else if (slowena) begin
            if (q == 4'd9) begin
                q <= 4'd0;
            end else begin
                q <= q + 4'd1;
            end
        end
    end

endmodule