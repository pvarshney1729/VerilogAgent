[BEGIN]
module TopModule (
    input logic [3:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Combinational logic for 4-input AND gate
    always @(*) begin
        out_and = &in;
    end

    // Combinational logic for 4-input OR gate
    always @(*) begin
        out_or = |in;
    end

    // Combinational logic for 4-input XOR gate
    always @(*) begin
        out_xor = ^in;
    end

endmodule
[DONE]