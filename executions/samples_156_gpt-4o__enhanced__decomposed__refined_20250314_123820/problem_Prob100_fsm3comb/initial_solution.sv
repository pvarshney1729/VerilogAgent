[BEGIN]
module TopModule (
    input logic clk,          // Clock signal for synchronous state transitions
    input logic rst_n,        // Active-low asynchronous reset
    input logic in,           // 1-bit input signal
    input logic [1:0] state,  // 2-bit current state input
    output logic [1:0] next_state, // 2-bit next state output
    output logic out          // 1-bit output
);

// Combinational logic for state transition and output
always_comb begin
    case (state)
        2'b00: begin // State A
            next_state = (in == 1'b0) ? 2'b00 : 2'b01;
            out = 1'b0;
        end
        2'b01: begin // State B
            next_state = (in == 1'b0) ? 2'b10 : 2'b01;
            out = 1'b0;
        end
        2'b10: begin // State C
            next_state = (in == 1'b0) ? 2'b00 : 2'b11;
            out = 1'b0;
        end
        2'b11: begin // State D
            next_state = (in == 1'b0) ? 2'b10 : 2'b01;
            out = 1'b1;
        end
        default: begin
            next_state = 2'b00; // Default to state A for undefined states
            out = 1'b0;
        end
    endcase
end

// Synchronous reset logic
always_ff @(posedge clk) begin
    if (!rst_n) begin
        next_state <= 2'b00; // Reset to state A
        out <= 1'b0;
    end
end

endmodule
[DONE]