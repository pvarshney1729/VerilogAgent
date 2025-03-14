[BEGIN]
module TopModule(
    input logic a, // 1-bit input
    input logic b, // 1-bit input
    output logic q // 1-bit output
);
    always_comb begin
        q = a & b; // AND operation
    end
endmodule
[DONE]