module TopModule (
    input  logic clk,                // Clock signal (1-bit input)
    input  logic reset,              // Synchronous active-high reset (1-bit input)
    output reg [2:0] ena,            // Enable signals for upper three BCD digits (3 bits output)
    output reg [15:0] q              // 4-digit BCD counter (16 bits output)
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'b0000000000000000; // Reset counter to 0
            ena <= 3'b000;             // Reset enable signals
        end else begin
            // Increment logic
            if (q[3:0] == 4'b1001) begin // Check ones digit
                q[3:0] <= 4'b0000;      // Reset ones digit
                ena[0] <= 1'b1;          // Enable tens digit increment
                if (q[7:4] == 4'b1001) begin // Check tens digit
                    q[7:4] <= 4'b0000;  // Reset tens digit
                    ena[1] <= 1'b1;      // Enable hundreds digit increment
                    if (q[11:8] == 4'b1001) begin // Check hundreds digit
                        q[11:8] <= 4'b0000; // Reset hundreds digit
                        ena[2] <= 1'b1;      // Enable thousands digit increment
                        if (q[15:12] < 4'b1001) begin // Check thousands digit
                            q[15:12] <= q[15:12] + 1'b1; // Increment thousands digit
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 1'b1; // Increment hundreds digit
                    end
                end else begin
                    q[7:4] <= q[7:4] + 1'b1; // Increment tens digit
                end
            end else begin
                q[3:0] <= q[3:0] + 1'b1; // Increment ones digit
                ena[0] <= 1'b0; // Disable tens digit increment
            end
        end
    end

    // Ensure enable signals are cleared when not incrementing
    always @(*) begin
        if (q[3:0] != 4'b1001) ena[0] = 1'b0;
        if (q[7:4] != 4'b1001) ena[1] = 1'b0;
        if (q[11:8] != 4'b1001) ena[2] = 1'b0;
    end

endmodule