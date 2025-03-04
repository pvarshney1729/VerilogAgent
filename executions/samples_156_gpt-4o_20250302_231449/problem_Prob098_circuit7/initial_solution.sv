```verilog
module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    // Initialize the output to a known state
    initial begin
        q = 1'b0;
    end

    // Sequential logic block
    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= ~q; // Toggle the output state
        end
        // If a == 0, the state of q remains unchanged
    end
endmodule
```