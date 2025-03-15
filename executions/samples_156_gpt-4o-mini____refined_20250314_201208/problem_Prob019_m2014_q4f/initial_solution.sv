module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);
    logic and_out;

    // Combinational logic with inverted in2
    always @(*) begin
        and_out = in1 & ~in2; // AND gate with bubble on in2
    end

    // Assign the output
    assign out = and_out;

endmodule