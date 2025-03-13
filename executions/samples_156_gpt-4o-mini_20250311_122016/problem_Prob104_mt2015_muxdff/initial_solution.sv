```verilog
module TopModule (
    input logic clk,
    input logic L,
    input logic q_in,
    input logic r_in,
    input logic reset_n,
    output logic Q
);

    logic mux_out;

    // 2:1 Multiplexer
    always @(*) begin
        mux_out = (L) ? r_in : q_in;
    end

    // D Flip-Flop with Synchronous Reset
    always @(posedge clk) begin
        if (!reset_n)
            Q <= 1'b0;
        else
            Q <= mux_out;
    end

endmodule
```