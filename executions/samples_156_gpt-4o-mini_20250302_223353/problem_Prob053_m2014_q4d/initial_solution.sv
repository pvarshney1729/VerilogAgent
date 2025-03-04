module TopModule (
    input logic clk,
    input logic in,
    output logic out
);

    logic xor_result;

    // XOR operation
    assign xor_result = in ^ out;

    // D Flip-Flop
    always @(posedge clk) begin
        out <= xor_result;
    end

endmodule