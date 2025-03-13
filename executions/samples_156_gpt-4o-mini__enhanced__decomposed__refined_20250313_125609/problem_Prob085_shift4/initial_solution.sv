[BEGIN]
module TopModule (
    input  logic clk,       // Clock input (1 bit)
    input  logic areset,    // Synchronous active-high reset (1 bit)
    input  logic load,      // Synchronous active-high load signal (1 bit)
    input  logic ena,       // Synchronous active-high enable signal for shifting (1 bit)
    input  logic [3:0] data, // Input data for loading (4 bits)
    output logic [3:0] q     // Output of shift register (4 bits)
);

always @(posedge clk) begin
    if (areset) begin
        q <= 4'b0000; // Reset state: all bits are set to 0
    end else if (load) begin
        q <= data; // Load data into q
    end else if (ena) begin
        q <= {1'b0, q[3:1]}; // Shift right operation
    end
end

endmodule
[DONE]