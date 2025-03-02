module TopModule (
    input logic clk,            // Clock signal for synchronous operations
    input logic rst_n,          // Active-low synchronous reset
    input logic in,             // 1-bit input signal
    input logic [3:0] state,    // 4-bit one-hot encoded current state
    output logic [3:0] next_state, // 4-bit one-hot encoded next state
    output logic out             // 1-bit output signal
);

always @(posedge clk) begin
    if (!rst_n) begin
        next_state <= 4'b0001; // Reset to State A
        out <= 0;
    end else begin
        case (state)
            4'b0001: begin // State A
                next_state <= (in) ? 4'b0010 : 4'b0001;
                out <= 0;
            end
            4'b0010: begin // State B
                next_state <= (in) ? 4'b0010 : 4'b0100;
                out <= 0;
            end
            4'b0100: begin // State C
                next_state <= (in) ? 4'b1000 : 4'b0001;
                out <= 0;
            end
            4'b1000: begin // State D
                next_state <= (in) ? 4'b0010 : 4'b0100;
                out <= 1;
            end
            default: begin // Illegal state handling
                next_state <= 4'b0001; // Reset to State A
                out <= 0;
            end
        endcase
    end
end
endmodule