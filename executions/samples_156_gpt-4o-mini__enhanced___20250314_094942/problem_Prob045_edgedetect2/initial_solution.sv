module TopModule (
    input logic clk,               // Clock signal (positive edge triggered)
    input logic [7:0] in,         // 8-bit input vector
    output logic [7:0] anyedge     // 8-bit output vector indicating edges
);

logic [7:0] in_prev; // Register to hold previous state of input

// Initial state
initial begin
    anyedge = 8'b00000000; // Initialize anyedge to 0
    in_prev = 8'b00000000; // Initialize previous input to 0
end

// Main functionality
always @(posedge clk) begin
    // Detect transitions for each bit
    anyedge <= (in != in_prev); // Set anyedge to 1 where transitions occurred
    in_prev <= in; // Update previous input state
end

endmodule