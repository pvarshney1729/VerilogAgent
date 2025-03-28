module TopModule(
    input logic clk,
    input logic resetn,
    input logic [2:0] r,
    output logic [2:0] g
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State flip-flops with synchronous reset
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition logic
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
                // Since STATE_D is only entered when r[2] is 1 and no higher priority requests,
                // it stays in STATE_D as long as r[2] is 1.
                if (r[2])
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always_comb begin
        // Default all grants to 0
        g = 3'b000;
        case (current_state)
            STATE_B: g[0] = 1'b1; // Grant for device 0
            STATE_C: g[1] = 1'b1; // Grant for device 1
            STATE_D: g[2] = 1'b1; // Grant for device 2
            default: g = 3'b000; // No grants
        endcase
    end

endmodule