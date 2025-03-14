[BEGIN]
module TopModule (
    input  logic in1,
    input  logic in2,
    output logic out
);

    // Combinational logic for AND gate with in2 inverted
    always @(*) begin
        out = in1 & ~in2;
    end

endmodule
[DONE]