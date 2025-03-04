module TopModule (
    input wire clk,
    input wire reset,
    output reg [9:0] q
);

    // Initial state
    initial begin
        q = 10'b0;
    end

    // Sequential logic
    always @(posedge clk) begin
        if (reset) begin
            q <= 10'b0; // Reset counter to zero
        end else if (q == 10'd999) begin
            q <= 10'b0; // Wrap around after reaching 999
        end else begin
            q <= q + 1; // Increment counter
        end
    end

endmodule