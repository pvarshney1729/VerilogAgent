module TopModule (
    input logic clk,
    input logic x,
    output logic z
);
    logic dff_xor, dff_and, dff_or;
    logic xor_out, and_out, or_out;

    // D Flip-Flops with synchronous reset
    always @(posedge clk) begin
        dff_xor <= xor_out;
        dff_and <= and_out;
        dff_or <= or_out;
    end

    // Logic Gates
    assign xor_out = x ^ dff_xor;
    assign and_out = x & ~dff_and;
    assign or_out = x | ~dff_or;

    // NOR Gate
    assign z = ~(dff_xor | dff_and | dff_or);
endmodule