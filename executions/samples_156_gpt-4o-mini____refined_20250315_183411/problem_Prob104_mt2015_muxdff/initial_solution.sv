[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic L,
    input logic q_in,
    input logic r_in,
    output logic Q
);

    logic mux_out;

    // 2:1 Multiplexer
    always @(*) begin
        mux_out = L ? r_in : q_in;
    end

    // Flip-Flop with synchronous reset
    always @(posedge clk) begin
        Q <= mux_out; // Q gets updated on the positive edge of clk
    end

endmodule
```
[DONE]