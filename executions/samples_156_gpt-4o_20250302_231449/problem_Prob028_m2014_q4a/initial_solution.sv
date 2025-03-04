module TopModule (
    input logic d,
    input logic ena,
    output logic q
);
    // D latch implementation
    always @(*) begin
        if (ena) begin
            q = d;
        end
        // If ena is low, q retains its value (no explicit action needed)
    end
endmodule