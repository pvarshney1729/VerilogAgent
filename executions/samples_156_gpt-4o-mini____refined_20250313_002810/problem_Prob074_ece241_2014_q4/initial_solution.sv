[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic x,
    output logic z
);

    logic ff_xor, ff_and, ff_or;
    logic xor_out, and_out, or_out;

    // D flip-flops with synchronous reset
    always @(posedge clk) begin
        ff_xor <= xor_out;
        ff_and <= and_out;
        ff_or <= or_out;
    end

    // Combinational logic
    always @(*) begin
        xor_out = x ^ ff_xor;
        and_out = x & ~ff_and;
        or_out  = x | ~ff_or;
    end

    // NOR gate output
    assign z = ~(ff_xor | ff_and | ff_or);

endmodule
[DONE]