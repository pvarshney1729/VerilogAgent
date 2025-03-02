module TopModule (
    input logic clk,
    input logic reset,
    input logic [3:0] in_a,
    input logic [3:0] in_b,
    output logic [3:0] out_sum,
    output logic carry_out
);

    // Combinational logic for addition
    always @(*) begin
        {carry_out, out_sum} = in_a + in_b;
    end

endmodule