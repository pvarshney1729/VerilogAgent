```verilog
module TopModule (
    input logic clk,
    input logic L,
    input logic q_in,
    input logic r_in,
    output logic Q
);

    logic Q_next;

    always @(*) begin
        Q_next = (L) ? r_in : q_in;
    end

    always_ff @(posedge clk) begin
        Q <= Q_next;
    end

endmodule
```