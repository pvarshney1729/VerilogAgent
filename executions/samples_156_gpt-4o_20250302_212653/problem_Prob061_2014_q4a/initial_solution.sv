module TopModule (
    input logic clk,     // Clock signal, triggers on positive edge
    input logic w,       // Data input from the previous stage of the shift register
    input logic R,       // Data to load into the shift register
    input logic E,       // Enable signal for shifting
    input logic L,       // Load signal, indicates when to load the value R
    output logic Q       // Output of this stage of the shift register
);

    // Initial state for simulation purposes
    initial begin
        Q = 1'b0;
    end

    // Sequential logic for shift and load operations
    always @(posedge clk) begin
        if (L) begin
            Q <= R; // Load operation takes precedence
        end else if (E) begin
            Q <= w; // Shift operation
        end
    end

endmodule