module TopModule (
    input logic clk,             // Clock input, 1-bit, unsigned
    input logic reset,           // Active high synchronous reset, 1-bit, unsigned
    output logic [3:0] q         // 4-bit output, unsigned with q[3] as the MSB
);
    // Initial state
    initial begin
        q = 4'b0001;            // Initialize q to 1 at the start
    end

    // Sequential logic, triggered on the positive edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001;       // Reset the counter to 1
        end else begin
            if (q == 4'b1010) begin
                q <= 4'b0001;   // Wrap around from 10 to 1
            end else begin
                q <= q + 1'b1;  // Increment the counter
            end
        end
    end
endmodule