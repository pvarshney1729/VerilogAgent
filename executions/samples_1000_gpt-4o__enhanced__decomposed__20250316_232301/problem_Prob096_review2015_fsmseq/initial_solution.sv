module TopModule(
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);

    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        S1    = 3'b001,
        S11   = 3'b010,
        S110  = 3'b011,
        FOUND = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition and output register
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == FOUND) begin
                start_shifting <= 1'b1;
            end
        end
    end

    // Combinational logic for next state determination
    always @(*) begin
        case (current_state)
            IDLE:   next_state = (data) ? S1 : IDLE;
            S1:     next_state = (data) ? S11 : IDLE;
            S11:    next_state = (data) ? S11 : S110;
            S110:   next_state = (data) ? FOUND : IDLE;
            FOUND:  next_state = FOUND; // Remain in FOUND once sequence is detected
            default: next_state = IDLE;
        endcase
    end

endmodule