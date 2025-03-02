module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    // Synchronous reset and state initialization
    always @(posedge clk) begin
        if (state == 1'b0) begin
            state <= 1'b0; // Reset state
        end else begin
            state <= ~state; // Toggle state for demonstration
        end
    end

    // Combinational logic for output q
    always @(*) begin
        q = (a & b) | (state); // Example combinational logic
    end

endmodule