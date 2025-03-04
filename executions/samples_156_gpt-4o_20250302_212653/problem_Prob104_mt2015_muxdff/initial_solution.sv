module TopModule (
    input logic clk,         // Clock signal for sequential logic
    input logic reset,       // Synchronous reset signal
    input logic L,           // Load enable signal
    input logic q_in,        // Input for the flip-flop
    input logic r_in,        // Input for the multiplexer
    output logic Q           // Output from the flip-flop
);

    always @(posedge clk) begin
        if (reset) begin
            Q <= 1'b0;       // Initialize Q to zero on reset
        end else begin
            Q <= L ? r_in : q_in;  // Select between r_in and q_in based on L
        end
    end

endmodule