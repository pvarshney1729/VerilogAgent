module TopModule (
    input logic clk,       // Clock signal
    input logic reset,     // Active-high synchronous reset
    output logic [9:0] q   // 10-bit counter output
);

    // Internal register for the counter
    logic [9:0] count;

    // Counter logic
    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 10'b0; // Reset counter to 0
        end else begin
            if (count == 10'd999) begin
                count <= 10'b0; // Wrap around to 0 after 999
            end else begin
                count <= count + 10'b1; // Increment counter
            end
        end
    end

    // Assign the internal counter to the output
    assign q = count;

endmodule