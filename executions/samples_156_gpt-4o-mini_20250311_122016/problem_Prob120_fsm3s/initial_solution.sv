```
[BEGIN]
module TopModule (
    input logic clk,       // Clock signal, positive edge-triggered
    input logic reset,     // Synchronous active high reset
    input logic in,        // 1-bit input signal
    output logic out       // 1-bit output signal
);

logic [1:0] state, next_state; // State and next state registers

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00; // State A
        out <= 1'b0;
    end else begin
        state <= next_state;
    end
end

// Next state and output logic
always @(*) begin
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
            next_state = 2'b00; // Default to state A on invalid state
            out = 1'b0;
        end
    endcase
end

endmodule
[DONE]
```