module TopModule(
    input logic clk,
    input logic in,
    output logic out
);

    // Intermediate signal for the XOR output
    logic xor_out;

    // Combinational logic for the XOR operation
    always @(*) begin
        xor_out = in ^ out;
    end

    // Sequential logic for the D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_out;
    end

endmodule