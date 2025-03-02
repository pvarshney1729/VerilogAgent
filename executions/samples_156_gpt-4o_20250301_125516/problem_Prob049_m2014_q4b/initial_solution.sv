module TopModule (
    input logic clk,    // Clock signal, one bit, unsigned
    input logic ar,     // Asynchronous reset signal, one bit, unsigned
    input logic d,      // Data input signal, one bit, unsigned
    output logic q      // Data output signal, one bit, unsigned
);

    // Initial state for simulation purposes
    initial begin
        q = 1'b0;
    end

    // D flip-flop with asynchronous reset
    always_ff @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0; // Asynchronous reset to 0
        end else begin
            q <= d;    // Latch data on rising edge of clock
        end
    end

endmodule