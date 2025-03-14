[BEGIN]
module TopModule (
    input  logic in1,
    input  logic in2,
    input  logic in3,
    output logic out
);

    logic xnor_result;

    always_comb begin
        // XNOR operation on in1 and in2
        xnor_result = ~(in1 ^ in2);

        // XOR operation with the result of XNOR and in3
        out = xnor_result ^ in3;
    end

endmodule
[DONE]