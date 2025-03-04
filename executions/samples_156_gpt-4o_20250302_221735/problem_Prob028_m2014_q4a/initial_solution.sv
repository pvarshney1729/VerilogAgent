module TopModule (
    input logic d,    // 1-bit data input
    input logic ena,  // 1-bit enable input
    output logic q    // 1-bit data output
);

    always @(*) begin
        if (ena)
            q = d;
    end

endmodule