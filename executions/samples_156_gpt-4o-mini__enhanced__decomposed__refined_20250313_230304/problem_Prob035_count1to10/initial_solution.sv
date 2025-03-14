[BEGIN]
module TopModule (
    input logic clk,            // Input: Clock signal (1 bit)
    input logic reset,          // Input: Active high synchronous reset signal (1 bit)
    output logic [3:0] q        // Output: 4-bit counter output (represents values 1 to 10)
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001;  // Reset state to 1
        end else begin
            if (q < 4'b1010) begin // Counting from 1 to 10 (1 to 10 in binary)
                q <= q + 1;       // Increment the counter
            end else begin
                q <= 4'b0001;     // Roll over to 1 after reaching 10
            end
        end
    end

    initial begin
        q = 4'b0001; // Initialize the counter to 1 on power-up
    end

endmodule
[DONE]