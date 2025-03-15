module moore_fsm (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S2 : S1;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S0: out = 1'b0;
            S1: out = 1'b1;
            S2: out = 1'b0;
            default: out = 1'b0;
        endcase
    end

    // State update logic with synchronous reset
    always @(*) begin
        if (reset) begin
            current_state = S0;
        end else begin
            current_state = next_state;
        end
    end

endmodule