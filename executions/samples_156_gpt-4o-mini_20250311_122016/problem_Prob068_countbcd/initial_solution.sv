```verilog
[BEGIN]
module TopModule (
    input  logic       clk,      // Clock signal, positive edge-triggered
    input  logic       reset,    // Active-high synchronous reset
    output logic [2:0] ena,      // Enable signals for higher BCD digits
    output logic [15:0] q        // 4-digit BCD counter output
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'b0000_0000_0000_0000; // Initialize q to 0000
            ena <= 3'b000;                // Initialize ena to 000
        end else begin
            // Increment the BCD counter
            ena <= 3'b000; // Reset ena signals for next clock cycle
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                ena[0] <= 1'b1; // Assert ena[0]
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    ena[1] <= 1'b1; // Assert ena[1]
                    if (q[11:8] == 4'd9) begin
                        q[11:8] <= 4'd0;
                        ena[2] <= 1'b1; // Assert ena[2]
                        if (q[15:12] == 4'd9) begin
                            q[15:12] <= 4'd0; // Roll over to 0000
                        end else begin
                            q[15:12] <= q[15:12] + 4'd1; // Increment thousands
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 4'd1; // Increment hundreds
                    end
                end else begin
                    q[7:4] <= q[7:4] + 4'd1; // Increment tens
                end
            end else begin
                q[3:0] <= q[3:0] + 4'd1; // Increment ones
            end
        end
    end

endmodule
[DONE]
```