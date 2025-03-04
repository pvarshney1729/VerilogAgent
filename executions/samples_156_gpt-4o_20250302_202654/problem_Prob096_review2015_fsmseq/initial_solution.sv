module TopModule (
    input  logic clk,           // Clock input, triggering on the positive edge
    input  logic reset,         // Active high synchronous reset
    input  logic data,          // Input data stream, 1-bit unsigned
    output logic start_shifting // Output flag, 1-bit unsigned
);

    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        S1    = 3'b001,
        S11   = 3'b010,
        S110  = 3'b011,
        FOUND = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (data)
                    next_state = S1;
                else
                    next_state = IDLE;
            end
            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = IDLE;
            end
            S11: begin
                if (!data)
                    next_state = S110;
                else
                    next_state = IDLE;
            end
            S110: begin
                if (data)
                    next_state = FOUND;
                else
                    next_state = IDLE;
            end
            FOUND: begin
                next_state = FOUND;
            end
            default: next_state = IDLE;
        endcase
    end

    // State register and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == FOUND)
                start_shifting <= 1'b1;
            else
                start_shifting <= 1'b0;
        end
    end

endmodule