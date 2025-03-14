[BEGIN]
module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);

    logic not_in2;

    // Invert in2
    always @(*) begin
        not_in2 = ~in2;
    end

    // AND gate with inverted input
    always @(*) begin
        out = in1 & not_in2;
    end

endmodule
[DONE]