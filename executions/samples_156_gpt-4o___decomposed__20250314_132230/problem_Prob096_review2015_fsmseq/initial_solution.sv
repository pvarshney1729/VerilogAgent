module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic data,
    output logic start_shifting
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        S1      = 3'b001,
        S11     = 3'b010,
        S110    = 3'b011,
        S1101   = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE:   next_state = (data == 1'b1) ? S1    : IDLE;
            S1:     next_state = (data == 1'b1) ? S11   : IDLE;
            S11:    next_state = (data == 1'b0) ? S110  : S11;
            S110:   next_state = (data == 1'b1) ? S1101 : IDLE;
            S1101:  next_state = S1101;  // Remain in S1101 once sequence is detected
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 1'b0;
        else if (current_state == S1101)
            start_shifting <= 1'b1;
    end

endmodule