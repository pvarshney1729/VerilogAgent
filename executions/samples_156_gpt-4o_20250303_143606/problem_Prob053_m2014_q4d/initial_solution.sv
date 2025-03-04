module TopModule (
    input logic clk,
    input logic in,
    output logic out
);

    logic xor_result;

    // Initial state for simulation
    initial begin
        out = 1'b0;
    end

    // Combinational logic for XOR operation
    always @(*) begin
        xor_result = in ^ out;
    end

    // Sequential logic for D flip-flop
    always @(posedge clk) begin
        out <= xor_result;
    end

endmodule