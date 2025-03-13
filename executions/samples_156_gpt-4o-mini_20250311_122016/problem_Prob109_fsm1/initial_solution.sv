```verilog
[BEGIN]
module TopModule (
    input logic clk,        // Clock input, single bit
    input logic areset,     // Asynchronous reset, active high, single bit
    input logic in,         // Single-bit input signal to the FSM
    output logic out        // Single-bit output signal of the FSM
);

    logic state; // Current state of the FSM

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b1; // State B
        end else begin
            case (state)
                1'b0: begin // State A
                    if (in == 1'b0) begin
                        state <= 1'b1; // Transition to State B
                    end else begin
                        state <= 1'b0; // Remain in State A
                    end
                end
                1'b1: begin // State B
                    if (in == 1'b0) begin
                        state <= 1'b0; // Transition to State A
                    end else begin
                        state <= 1'b1; // Remain in State B
                    end
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            1'b0: out = 1'b0; // Output for State A
            1'b1: out = 1'b1; // Output for State B
        endcase
    end

endmodule
[DONE]
```