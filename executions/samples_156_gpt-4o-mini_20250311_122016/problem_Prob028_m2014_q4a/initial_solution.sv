[BEGIN]
module TopModule (
    input logic d,
    input logic ena,
    output logic q
);

    // Initial state
    initial begin
        q = 1'b0;
    end

    // Always block for implementing D latch behavior
    always @(*) begin
        if (ena) begin
            q = d;
        end
        // When ena is low, q retains its previous value.
    end

endmodule
[DONE]