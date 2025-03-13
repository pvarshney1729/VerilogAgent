module TopModule (
    input logic d,        // Input data signal (1-bit, unsigned)
    input logic ena,      // Enable signal (1-bit, unsigned)
    output logic q        // Output latch signal (1-bit, unsigned)
);

initial begin
    q = 1'b0; // Initialize output `q` to 0
end

always @(*) begin
    if (ena) begin
        q = d; // When `ena` is high, latch the value of `d`
    end
    // If `ena` is low, `q` retains its previous value (latch behavior)
end

endmodule