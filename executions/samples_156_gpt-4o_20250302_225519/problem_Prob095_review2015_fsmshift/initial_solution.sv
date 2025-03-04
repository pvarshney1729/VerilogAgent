module TopModule(
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        ENABLE1 = 3'b001,
        ENABLE2 = 3'b010,
        ENABLE3 = 3'b011,
        ENABLE4 = 3'b100,
        HOLD    = 3'b101
    } state_t;

    state_t current_state, next_state;
    logic [2:0] cycle_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= ENABLE1;
            cycle_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == ENABLE1 || current_state == ENABLE2 || 
                current_state == ENABLE3 || current_state == ENABLE4) begin
                cycle_count <= cycle_count + 1;
            end else begin
                cycle_count <= 3'b000;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (reset)
                    next_state = ENABLE1;
                else
                    next_state = IDLE;
            end
            ENABLE1: next_state = ENABLE2;
            ENABLE2: next_state = ENABLE3;
            ENABLE3: next_state = ENABLE4;
            ENABLE4: next_state = HOLD;
            HOLD: begin
                if (reset)
                    next_state = ENABLE1;
                else
                    next_state = HOLD;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            ENABLE1, ENABLE2, ENABLE3, ENABLE4: shift_ena = 1'b1;
            default: shift_ena = 1'b0;
        endcase
    end

endmodule