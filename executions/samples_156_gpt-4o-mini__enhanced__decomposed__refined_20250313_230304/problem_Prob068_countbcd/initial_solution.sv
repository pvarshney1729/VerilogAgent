[BEGIN]
```verilog
module TopModule (
    input logic clk,                // Clock signal (1 bit)
    input logic reset,              // Synchronous active-high reset signal (1 bit)
    output logic [2:0] ena,         // Enable signals for each digit (3 bits)
    output logic [15:0] q           // 16-bit output for BCD counter
);

always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0000_0000_0000_0000; // Reset all digits to zero
        ena <= 3'b000;                // Disable all enables
    end else begin
        ena <= 3'b000; // Reset enable signals

        // Increment ones place
        if (q[3:0] < 4'b1001) begin
            q[3:0] <= q[3:0] + 1;
            ena[0] <= 1'b1;
        end else begin
            q[3:0] <= 4'b0000; // Reset ones place
            // Increment tens place
            if (q[7:4] < 4'b1001) begin
                q[7:4] <= q[7:4] + 1;
                ena[1] <= 1'b1;
            end else begin
                q[7:4] <= 4'b0000; // Reset tens place
                // Increment hundreds place
                if (q[11:8] < 4'b1001) begin
                    q[11:8] <= q[11:8] + 1;
                    ena[2] <= 1'b1;
                end else begin
                    q[11:8] <= 4'b0000; // Reset hundreds place
                    // Increment thousands place
                    if (q[15:12] < 4'b1001) begin
                        q[15:12] <= q[15:12] + 1;
                    end else begin
                        q <= 16'b0000_0000_0000_0000; // Reset all to zero if thousands place overflows
                    end
                end
            end
        end
    end
end

endmodule
```
[DONE]