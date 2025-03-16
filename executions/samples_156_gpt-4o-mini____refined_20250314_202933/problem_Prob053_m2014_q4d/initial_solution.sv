```
[BEGIN]
module TopModule (
    input logic clk,
    input logic in,
    output logic out
);
    logic d_ff_out;
    logic xor_out;

    // Combinational logic for XOR
    always @(*) begin
        xor_out = in ^ d_ff_out;
    end

    // D flip-flop with synchronous reset
    always @(posedge clk) begin
        d_ff_out <= xor_out;
    end

    // Output assignment
    assign out = d_ff_out;

endmodule
[DONE]
```