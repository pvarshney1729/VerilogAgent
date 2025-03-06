module TopModule (
    input logic clk, // Clock signal, 1 bit
    input logic d,   // Data input signal, 1 bit
    input logic r,   // Reset signal, 1 bit, active high
    output logic q   // Output signal, 1 bit
);

    // On the rising edge of the clock
    always_ff @(posedge clk) begin
        if (r) begin
            q <= 1'b0; // Reset output to 0
        end else begin
            q <= d;    // Sample and output the input data
        end
    end

endmodule