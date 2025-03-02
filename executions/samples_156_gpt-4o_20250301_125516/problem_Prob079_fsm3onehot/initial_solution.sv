```verilog
module TopModule (
    input logic clk,            // Clock signal for sequential logic
    input logic rst_n,          // Active-low synchronous reset signal
    input logic in,             // 1-bit input signal
    input logic [3:0] state,    // 4-bit one-hot encoded current state
    output logic [3:0] next_state, // 4-bit one-hot encoded next state
    output logic out            // 1-bit output signal
);

always_ff @(posedge clk) begin
    if (!rst_n) begin
        next_state <= 4'b0001; // Default to state A on reset
    end else begin
        case(state)
            4'b0001: begin // State A
                next_state <= in ? 4'b0010 : 4'b0001;
                out <= 0;
            end
            4'b0010: begin // State B
                next_state <= in ? 4'b0010 : 4'b0100;
                out <= 0;
            end
            4'b0100: begin // State C
                next_state <= in ? 4'b1000 : 4'b0001;
                out <= 0;
            end
            4'b1000: begin // State D
                next_state <= in ? 4'b0010 : 4'b0100;
                out <= 1;
            end
            default: begin // Default case for invalid state
                next_state <= 4'b0001; // Reset to state A
                out <= 0;
            end
        endcase
    end
end

endmodule
```