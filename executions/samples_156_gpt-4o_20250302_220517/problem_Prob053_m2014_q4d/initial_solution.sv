module TopModule(
    input logic clk,
    input logic in,
    output logic out
);

    logic xor_result;

    // Combinational logic for XOR operation
    always_comb begin
        xor_result = in ^ out;
    end

    // Sequential logic for D flip-flop
    always_ff @(posedge clk) begin
        out <= xor_result;
    end

    // Initial condition for simulation
    initial begin
        out = 1'b0;
    end

endmodule