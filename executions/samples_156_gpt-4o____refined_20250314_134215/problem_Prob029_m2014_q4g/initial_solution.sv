[BEGIN]
module TopModule (
    input  logic in1,
    input  logic in2,
    input  logic in3,
    output logic out
);

    logic xnor_out;

    always @(*) begin
        // XNOR operation with explicit size for constants
        xnor_out = ~(in1 ^ in2);
        // XOR operation
        out = xnor_out ^ in3;
    end

endmodule
[DONE]