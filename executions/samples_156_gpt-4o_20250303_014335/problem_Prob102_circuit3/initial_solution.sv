module TopModule (
    input logic a,  // Single-bit input signal, active-high.
    input logic b,  // Single-bit input signal, active-high.
    input logic c,  // Single-bit input signal, active-high.
    input logic d,  // Single-bit input signal, active-high.
    output logic q  // Single-bit output signal, active-high.
);

    always @(*) begin
        q = (b & d) | (c & (a | b));
    end

endmodule