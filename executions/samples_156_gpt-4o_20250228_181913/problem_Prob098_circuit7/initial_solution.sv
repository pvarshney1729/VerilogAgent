```verilog
module TopModule (
    input logic clk,
    input logic a,
    output logic q
);
    logic prev_a; // Register to track the previous state of 'a'

    initial begin
        q = 1'b0;      // Initialize output
        prev_a = 1'b0; // Initialize previous 'a'
    end

    always @(posedge clk) begin
        if (a && !prev_a) begin
            q <= ~q; // Toggle q when 'a' transitions from 0 to 1
        end
        prev_a <= a; // Update prev_a to current 'a'
    end
endmodule
```