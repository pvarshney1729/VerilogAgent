[BEGIN]
module TopModule (
    input logic clk,          // Clock signal, positive edge triggered
    input logic reset,        // Synchronous active high reset
    input logic in,           // FSM input signal
    output logic out          // FSM output signal
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state; // State registers

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A; // Reset to state A
            out <= 1'b0;              // Set output to 0 on reset
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    always_comb begin
        case (current_state)
            STATE_A: begin
                next_state = (in == 1'b0) ? STATE_A : STATE_B;
                out = 1'b0;
            end
            STATE_B: begin
                next_state = (in == 1'b0) ? STATE_C : STATE_B;
                out = 1'b0;
            end
            STATE_C: begin
                next_state = (in == 1'b0) ? STATE_A : STATE_D;
                out = 1'b0;
            end
            STATE_D: begin
                next_state = (in == 1'b0) ? STATE_C : STATE_B;
                out = 1'b1;
            end
            default: begin
                next_state = STATE_A;
                out = 1'b0;
            end
        endcase
    end

endmodule
[Done]