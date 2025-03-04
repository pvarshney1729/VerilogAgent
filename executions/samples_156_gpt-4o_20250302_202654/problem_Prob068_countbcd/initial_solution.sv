module TopModule (
    input logic clk,            // Clock signal (1 bit)
    input logic reset,          // Synchronous active-high reset (1 bit)
    output logic [2:0] ena,     // Enable signals for BCD increments (3 bits, unsigned)
    output logic [15:0] q       // 4-digit BCD counter value (16 bits, unsigned)
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 16'b0;
            ena <= 3'b0;
        end else begin
            // Default ena to 0
            ena <= 3'b0;
            
            // Increment ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                // Increment tens digit
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    ena[1] <= 1'b1;
                    // Increment hundreds digit
                    if (q[11:8] == 4'd9) begin
                        q[11:8] <= 4'd0;
                        ena[2] <= 1'b1;
                        // Increment thousands digit
                        if (q[15:12] == 4'd9) begin
                            q[15:12] <= 4'd0;
                            ena[3] <= 1'b0; // No further carry
                        end else begin
                            q[15:12] <= q[15:12] + 4'd1;
                            ena[3] <= 1'b1;
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 4'd1;
                        ena[2] <= 1'b1;
                    end
                end else begin
                    q[7:4] <= q[7:4] + 4'd1;
                    ena[1] <= 1'b1;
                end
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
            end
        end
    end

endmodule