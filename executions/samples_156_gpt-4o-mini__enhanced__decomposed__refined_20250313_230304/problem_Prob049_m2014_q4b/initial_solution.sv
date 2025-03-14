```
[BEGIN]
module TopModule(
    input logic clk,      // Clock signal
    input logic ar,       // Asynchronous reset signal
    input logic d,        // Data input signal
    output logic q       // D flip-flop output
);

    always_ff @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0; // Asynchronous reset
        end else begin
            q <= d;    // D flip-flop behavior
        end
    end

endmodule
[DONE]
```