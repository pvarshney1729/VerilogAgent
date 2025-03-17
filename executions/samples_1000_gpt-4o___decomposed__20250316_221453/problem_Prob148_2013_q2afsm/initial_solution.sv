module TopModule(
    input logic clk,
    input logic resetn,
    input logic [2:0] r,
    output logic [2:0] g
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_A: begin
                if (r[0])
                    next_state = STATE_B;
                else if (r[1])
                    next_state = STATE_C;
                else if (r[2])
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (r[0])
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_C: begin
                if (r[1])
                    next_state = STATE_C;
                else
                    next_state = STATE_A;
            end
            STATE_D: begin
                next_state = STATE_A;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always_comb begin
        g = 3'b000; // Default output
        case (current_state)
            STATE_B: g[0] = 1;
            STATE_C: g[1] = 1;
            // g[2] remains 0 as per the specification
            default: g = 3'b000;
        endcase
    end

endmodule