module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    // Counter state initialization
    always @(posedge clk) begin
        if (reset) begin
            // Synchronous reset to 1
            q <= 4'b0001;
        end else begin
            // Increment counter on clock edge
            if (q == 4'b1010) begin
                // Reset to 1 if count reaches 10
                q <= 4'b0001;
            end else begin
                // Increment the counter
                q <= q + 1;
            end
        end
    end

    // Initialize q to 1 in simulation
    initial begin
        q = 4'b0001;
    end

endmodule