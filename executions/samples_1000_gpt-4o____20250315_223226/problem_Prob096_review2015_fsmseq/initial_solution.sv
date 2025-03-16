module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic data,
    output logic start_shifting
);

    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        S1    = 3'b001,
        S11   = 3'b010,
        S110  = 3'b011,
        S1101 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE:  next_state = (data) ? S1 : IDLE;
            S1:    next_state = (data) ? S11 : IDLE;
            S11:   next_state = (data) ? S11 : S110;
            S110:  next_state = (data) ? S1101 : IDLE;
            S1101: next_state = S1101; // Stay in S1101 once reached
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 1'b0;
        end else if (current_state == S1101) begin
            start_shifting <= 1'b1;
        end
    end

endmodule