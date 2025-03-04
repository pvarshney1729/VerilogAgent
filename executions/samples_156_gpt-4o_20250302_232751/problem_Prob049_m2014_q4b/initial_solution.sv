module TopModule (
    input logic clk,
    input logic ar,
    input logic d,
    output logic q
);

    // Asynchronous reset with priority over clock
    always_ff @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0;  // Reset state
        end else begin
            q <= d;  // Latch data on rising edge of clk
        end
    end

endmodule