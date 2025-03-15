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
    always @(*) begin
        case (current_state)
            IDLE: 
                if (data) 
                    next_state = S1;
                else 
                    next_state = IDLE;
            S1: 
                if (data) 
                    next_state = S11;
                else 
                    next_state = IDLE;
            S11: 
                if (~data) 
                    next_state = S110;
                else 
                    next_state = S11;
            S110: 
                if (data) 
                    next_state = S1101;
                else 
                    next_state = IDLE;
            S1101: 
                next_state = S1101;
            default: 
                next_state = IDLE;
        endcase
    end

    // State register logic
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        start_shifting = (current_state == S1101);
    end

endmodule