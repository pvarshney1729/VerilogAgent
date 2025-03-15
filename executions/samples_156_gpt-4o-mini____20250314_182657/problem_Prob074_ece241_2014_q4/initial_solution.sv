module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    logic ff_xor_out;
    logic ff_and_out;
    logic ff_or_out;

    // D flip-flops with synchronous reset
    always @(posedge clk) begin
        ff_xor_out <= x ^ ff_xor_out;
        ff_and_out <= x & ~ff_and_out;
        ff_or_out <= x | ~ff_or_out;
    end

    // NOR gate output
    assign z = ~(ff_xor_out | ff_and_out | ff_or_out);

endmodule