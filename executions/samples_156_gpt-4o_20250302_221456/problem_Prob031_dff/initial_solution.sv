module TopModule (
    input logic clk,          // Clock signal (1 bit)
    input logic d,            // Data input (1 bit)
    output logic q,           // Flip-flop output (1 bit)
    input logic rst_n         // Active-low asynchronous reset (1 bit)
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;  // Reset output to 0
        else
            q <= d;     // Capture data on rising edge of the clock
    end

endmodule