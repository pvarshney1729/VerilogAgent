module TopModule (
    input logic clk,         // Clock signal for state transitions
    input logic rst_n,       // Active-low synchronous reset
    input logic in,          // Input signal
    input logic [3:0] state, // Current state (one-hot encoded)
    output logic [3:0] next_state, // Next state (one-hot encoded)
    output logic out          // Output signal
);

always @(posedge clk) begin
    if (!rst_n) begin
        next_state <= 4'b0001; // Reset to State A
    end else begin
        case (state)
            4'b0001: next_state <= (in ? 4'b0010 : 4'b0001); // State A
            4'b0010: next_state <= (in ? 4'b0010 : 4'b0100); // State B
            4'b0100: next_state <= (in ? 4'b1000 : 4'b0001); // State C
            4'b1000: next_state <= (in ? 4'b0010 : 4'b0100); // State D
            default: next_state <= 4'b0001; // Default to State A for invalid states
        endcase
    end
end

always @(*) begin
    out = (state == 4'b1000) ? 1'b1 : 1'b0; // Output logic
end

endmodule