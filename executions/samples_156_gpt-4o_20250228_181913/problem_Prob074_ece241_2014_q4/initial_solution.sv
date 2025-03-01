module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    logic dff1, dff2, dff3;
    logic xor_out, and_out, or_out;

    // Combinational logic
    always @(*) begin
        xor_out = x ^ dff1;
        and_out = x & ~dff2;
        or_out  = x | ~dff3;
    end

    // Sequential logic with synchronous reset
    always_ff @(posedge clk) begin
        dff1 <= xor_out;
        dff2 <= and_out;
        dff3 <= or_out;
    end

    // Output logic
    assign z = ~(dff1 | dff2 | dff3);

endmodule