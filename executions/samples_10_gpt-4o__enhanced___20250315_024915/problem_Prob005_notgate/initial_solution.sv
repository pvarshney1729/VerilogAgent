module TopModule (
    input logic in,
    output logic out
);

    always @(*) begin
        out = ~in; // NOT operation
    end

endmodule