module TopModule (
    input  logic clk,
    input  logic in,
    output logic out
);

    logic xor_result;

    // Combinational logic for XOR
    always @(*) begin
        xor_result = in ^ out;
    end

    // Sequential logic for D Flip-Flop
    always @(posedge clk) begin
        out <= xor_result;
    end

endmodule