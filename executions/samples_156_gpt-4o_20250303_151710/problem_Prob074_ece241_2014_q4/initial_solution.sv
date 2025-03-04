module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    logic xor_out, and_out, or_out;
    logic q1, q2, q3;

    // Combinational Logic
    always @(*) begin
        xor_out = x ^ q1;
        and_out = x & ~q2;
        or_out = x | ~q3;
    end

    // Sequential Logic with Synchronous Reset
    always_ff @(posedge clk) begin
        if (reset) begin
            q1 <= 1'b0;
            q2 <= 1'b0;
            q3 <= 1'b0;
        end else begin
            q1 <= xor_out;
            q2 <= and_out;
            q3 <= or_out;
        end
    end

    // NOR Gate for Output
    assign z = ~(q1 | q2 | q3);

endmodule