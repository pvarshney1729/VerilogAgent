[BEGIN]
module TopModule (
    input logic in,   // 1-bit input
    output logic out  // 1-bit output
);
    always_comb begin
        out = in; // Direct wire-like behavior
    end
endmodule
[DONE]