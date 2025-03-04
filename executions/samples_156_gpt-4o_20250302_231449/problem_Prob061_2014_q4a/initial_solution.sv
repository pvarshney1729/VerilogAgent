module TopModule (
    input wire clk,  // Clock input, positive edge triggered
    input wire w,    // Data input from the previous stage
    input wire E,    // Shift enable input
    input wire R,    // Data to load
    input wire L,    // Load enable input
    output reg Q     // Output to the next stage
);

always @(posedge clk) begin
    if (L) begin
        Q <= R;
    end else if (E) begin
        Q <= w;
    end
    // No action when both E and L are low
end

endmodule