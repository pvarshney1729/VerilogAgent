module TopModule (
    input  logic clk,            // Clock signal
    input  logic reset,          // Synchronous active-high reset
    output logic [2:0] ena,      // Enable signals for upper three BCD digits
    output logic [15:0] q        // 4-digit BCD counter output
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'b0;
            ena <= 3'b0;
        end else begin
            // Increment logic for BCD counter
            if (q[3:0] == 4'b1001) begin
                q[3:0] <= 4'b0; // Reset ones place
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 4'b0; // Reset tens place
                    if (q[11:8] == 4'b1001) begin
                        q[11:8] <= 4'b0; // Reset hundreds place
                        if (q[15:12] == 4'b1001) begin
                            q[15:12] <= 4'b0; // Reset thousands place
                        end else begin
                            q[15:12] <= q[15:12] + 1; // Increment thousands place
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 1; // Increment hundreds place
                    end
                end else begin
                    q[7:4] <= q[7:4] + 1; // Increment tens place
                end
            end else begin
                q[3:0] <= q[3:0] + 1; // Increment ones place
            end
            
            // Enable signal logic
            ena[0] <= (q[7:0] == 8'b00001001); // Enable for tens
            ena[1] <= (q[11:0] == 12'b000000110001); // Enable for hundreds
            ena[2] <= (q[15:0] == 16'b0000000011111001); // Enable for thousands
        end
    end
endmodule