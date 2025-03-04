module TopModule(
    input  logic clk,           // Clock signal, triggers on positive edge
    input  logic reset,         // Synchronous, active-high reset
    input  logic data,          // Input data stream, one bit per clock cycle
    output logic start_shifting // Output signal, remains high after sequence detection
);

    // Example FSM state encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        DETECTED = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DETECTED)
                start_shifting <= 1'b1;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (current_state)
            IDLE: next_state = (data) ? S1 : IDLE;
            S1: next_state = (data) ? S11 : IDLE;
            S11: next_state = (data) ? S11 : S110;
            S110: next_state = (data) ? DETECTED : IDLE;
            DETECTED: next_state = DETECTED;
            default: next_state = IDLE;
        endcase
    end

endmodule