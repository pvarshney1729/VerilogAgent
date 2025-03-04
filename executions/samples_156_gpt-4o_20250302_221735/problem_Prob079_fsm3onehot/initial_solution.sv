module TopModule (
    input logic clk,          // Clock signal for synchronous operation
    input logic reset_n,      // Active-low asynchronous reset
    input logic in,           // 1-bit input signal
    input logic [3:0] state,  // 4-bit input representing the current state
    output logic [3:0] next_state, // 4-bit output representing the next state
    output logic out          // 1-bit output signal
);

    // State transition logic
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            next_state <= 4'b0001; // Reset to State A
        else begin
            case (state)
                4'b0001: next_state <= (in) ? 4'b0010 : 4'b0001; // A
                4'b0010: next_state <= (in) ? 4'b0010 : 4'b0100; // B
                4'b0100: next_state <= (in) ? 4'b1000 : 4'b0001; // C
                4'b1000: next_state <= (in) ? 4'b0010 : 4'b0100; // D
                default: next_state <= 4'b0001; // Default to A
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            4'b1000: out = 1'b1; // State D
            default: out = 1'b0;
        endcase
    end

endmodule