module TopModule (
    input logic d,
    input logic ena,
    output logic q
);

    // Initial condition for simulation
    initial begin
        q = 1'b0; // Initialize output to 0
    end

    // Implementing the D latch using an always block
    always @(*) begin
        if (ena) begin
            q = d; // When ena is high, q follows d
        end
        // When ena is low, q retains its value (no assignment needed)
    end

endmodule