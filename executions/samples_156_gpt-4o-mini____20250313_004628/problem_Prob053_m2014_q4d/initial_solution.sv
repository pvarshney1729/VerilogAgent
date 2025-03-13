module TopModule (
    input logic clk,
    input logic in,
    output logic out
);
    logic d_ff_out;

    // Combinational logic for XOR
    logic xor_out;
    assign xor_out = in ^ d_ff_out;

    // D flip-flop
    always @(posedge clk) begin
        d_ff_out <= xor_out;
    end

    // Output assignment
    assign out = d_ff_out;

endmodule