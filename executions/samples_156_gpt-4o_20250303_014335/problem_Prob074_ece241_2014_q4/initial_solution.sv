module TopModule (
    input logic clk,
    input logic reset_n,
    input logic x,
    output logic z
);

    logic dff1_q, dff2_q, dff3_q;
    logic xor_out, and_out, or_out;

    // Asynchronous reset logic
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            dff1_q <= 1'b0;
            dff2_q <= 1'b0;
            dff3_q <= 1'b0;
        end else begin
            dff1_q <= xor_out;
            dff2_q <= and_out;
            dff3_q <= or_out;
        end
    end

    // Combinational logic
    always_comb begin
        xor_out = x ^ dff1_q;
        and_out = x & ~dff2_q;
        or_out = x | ~dff3_q;
    end

    // NOR gate for output
    assign z = ~(dff1_q | dff2_q | dff3_q);

endmodule