[BEGIN]
module TopModule (
    input logic clk,        // Clock signal (1-bit input)
    input logic d,          // Data input (1-bit input)
    output logic q          // Data output (1-bit output)
);

    // Synchronous reset behavior
    always @(posedge clk) begin
        q <= d; // On the positive edge of clk, q takes the value of d
    end

    initial begin
        q = 1'b0; // Set initial value of q to 0
    end

endmodule
[DONE]