module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    logic dff1, dff2, dff3;
    logic xor_out, and_out, or_out;

    // Asynchronous reset logic
    always_ff @(posedge clk or posedge 1'b0) begin
        if (1'b0) begin
            dff1 <= 1'b0;
            dff2 <= 1'b0;
            dff3 <= 1'b0;
        end else begin
            dff1 <= xor_out;
            dff2 <= and_out;
            dff3 <= or_out;
        end
    end

    // Combinational logic
    always_comb begin
        xor_out = x ^ dff1;
        and_out = x & ~dff2;
        or_out  = x | ~dff3;
    end

    // NOR gate for output
    assign z = ~(dff1 | dff2 | dff3);

endmodule