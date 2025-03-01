```verilog
module TopModule (
    input wire        clk,  // Clock signal, 1-bit, active on rising edge
    input wire        a,    // Input signal, 1-bit
    output reg [2:0]  q     // Output, 3-bit, unsigned
);

    // Initialize q to 0
    initial begin
        q = 3'b000;
    end

    // Sequential logic for the counter
    always @(posedge clk) begin
        if (a == 1'b0) begin
            if (q == 3'b111) begin
                q <= 3'b000;  // Wrap around to 0 when q reaches 7
            end else begin
                q <= q + 1'b1;  // Increment q
            end
        end
        // If a is 1, q holds its value, no need for an else statement
    end

endmodule
```