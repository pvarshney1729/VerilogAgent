module TopModule(
    input logic d,    // 1-bit data input
    input logic ena,  // 1-bit enable signal
    output logic q    // 1-bit data output
);

    // D latch implementation
    always @(*) begin
        if (ena) begin
            q = d;  // When enabled, latch the input to the output
        end
    end

endmodule