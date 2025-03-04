module TopModule (
    input wire clk,    // Clock signal, positive edge-triggered
    input wire rst,    // Synchronous reset signal
    input wire w,      // Input from the previous stage of the shift register
    input wire R,      // Value to load into the register
    input wire E,      // Enable signal for shifting
    input wire L,      // Load signal, prioritizes loading over shifting
    output reg Q       // Output to the next stage or external circuit
);

always @(posedge clk) begin
    if (rst) begin
        Q <= 1'b0;  // Define reset behavior
    end else if (L) begin
        Q <= R;    // Load R into Q
    end else if (E) begin
        Q <= w;    // Shift w into Q
    end
    // No else needed as Q retains its value otherwise
end

endmodule