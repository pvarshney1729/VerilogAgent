module TopModule (
    input logic clk,
    input logic in,
    output logic out
);

    // Intermediate signal for the XOR output
    logic xor_out;

    // Combinational logic block for XOR operation
    assign xor_out = in ^ out;

    // Sequential logic block for D flip-flop
    always @(posedge clk) begin
        out <= xor_out; // Capture XOR output on the rising edge of clk
    end

endmodule