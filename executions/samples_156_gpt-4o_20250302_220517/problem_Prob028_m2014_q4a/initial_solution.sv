module TopModule (
    input logic d,       // Single-bit input data
    input logic ena,     // Single-bit enable signal
    output logic q       // Single-bit output, registered
);

    always @(*) begin
        if (ena) begin
            q = d;
        end
        // Else, retain the previous state of q (handled by default in Verilog)
    end

endmodule