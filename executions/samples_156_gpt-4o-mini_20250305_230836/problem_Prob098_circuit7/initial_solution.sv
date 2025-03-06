```
[BEGIN]
module TopModule (
    input logic clk,     // Clock signal, positive edge-triggered
    input logic a,       // Input signal 'a'
    output logic q       // Output signal 'q', defined as a logic for sequential logic
);

    always_ff @(posedge clk) begin
        if (a == 1'b1) begin
            q <= ~q;  // Toggle q when 'a' is 1
        end
        // Implicitly, if a is 0, q retains its last value
    end

    initial begin
        q = 1'b0;  // Initialize q to 0
    end

endmodule
[DONE]
```