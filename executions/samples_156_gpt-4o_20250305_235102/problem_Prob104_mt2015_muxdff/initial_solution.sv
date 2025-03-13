```verilog
[BEGIN]
module TopModule (
    input  logic clk,        // Clock input, active on the rising edge
    input  logic L,          // Load control signal
    input  logic q_in,       // Input to the flip-flop when L is not asserted
    input  logic r_in,       // Input to the flip-flop when L is asserted
    output logic Q           // Output from the flip-flop
);

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end

endmodule
[DONE]
```