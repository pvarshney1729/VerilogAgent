module TopModule (
    input logic a,        // Input signal a (1-bit)
    input logic b,        // Input signal b (1-bit)
    output logic q        // Output signal q (1-bit)
);

always @(*) begin
    case ({a, b})
        2'b00: q = 1'b0;
        2'b01: q = 1'b0;
        2'b10: q = 1'b0;
        2'b11: q = 1'b1;
        default: q = 1'b0; // Fallback to ensure q is defined for all input combinations
    endcase
end

endmodule