module TopModule (
    input logic clk,
    input logic d,
    input logic r,
    output logic q
);

    // Always block for D flip-flop with synchronous reset
    always @(posedge clk) begin
        if (r) begin
            q <= 1'b0; // Reset output to 0 when reset is high
        end else begin
            q <= d; // Update output to data input d on clock edge
        end
    end

    // Initial condition for simulation
    initial begin
        q = 1'b0; // Initialize output to 0
    end

endmodule