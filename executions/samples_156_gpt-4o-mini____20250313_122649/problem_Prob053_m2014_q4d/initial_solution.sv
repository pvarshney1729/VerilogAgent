module TopModule (
    input  logic clk,
    input  logic in,
    output logic out
);

    logic d_ff_out;

    // Combinational logic for XOR
    always @(*) begin
        out = in ^ d_ff_out;
    end

    // D flip-flop
    always @(posedge clk) begin
        d_ff_out <= out;
    end

endmodule