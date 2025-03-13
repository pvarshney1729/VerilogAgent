```
[BEGIN]
module TopModule (
    input logic clk,           // Clock signal
    input logic shift_ena,     // Enable signal for shifting operation
    input logic count_ena,     // Enable signal for counting operation
    input logic data,          // Serial data input for the shift register
    output logic [3:0] q       // 4-bit register output
);

    always @(posedge clk) begin
        if (shift_ena) begin
            // Shift operation (MSB first)
            q <= {q[2:0], data};
        end else if (count_ena) begin
            // Decrement operation with wrap around
            q <= (q == 4'b0000) ? 4'b1111 : q - 1;
        end
    end

    initial begin
        q = 4'b0000; // Initialize q to 0000
    end

endmodule
[DONE]
```