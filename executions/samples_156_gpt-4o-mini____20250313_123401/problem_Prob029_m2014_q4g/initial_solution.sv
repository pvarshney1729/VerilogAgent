module TopModule (
    input logic in1,
    input logic in2,
    input logic in3,
    output logic out
);

    logic xnor_out;

    // Combinational logic for XNOR and XOR
    always @(*) begin
        xnor_out = ~(in1 ^ in2); // XNOR operation
        out = xnor_out ^ in3;    // XOR operation
    end

endmodule