module TopModule(
    input logic clk,
    input logic reset,
    input logic pattern_detected,
    output logic shift_ena
);
    // State encoding
    typedef enum logic [2:0] {
        RESET = 3'b000, ENABLE1 = 3'b001, ENABLE2 = 3'b010,
        ENABLE3 = 3'b011, ENABLE4 = 3'b100, IDLE = 3'b101
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) 
            state <= RESET;
        else 
            state <= next_state;
    end
    
    // Next state and output logic
    always_comb begin
        shift_ena = 0;
        case (state)
            RESET: begin
                shift_ena = 1;
                next_state = ENABLE1;
            end
            ENABLE1: begin
                shift_ena = 1;
                next_state = ENABLE2;
            end
            ENABLE2: begin
                shift_ena = 1;
                next_state = ENABLE3;
            end
            ENABLE3: begin
                shift_ena = 1;
                next_state = ENABLE4;
            end
            ENABLE4: begin
                shift_ena = 1;
                next_state = IDLE;
            end
            IDLE: begin
                if (pattern_detected) 
                    next_state = ENABLE1;
                else 
                    next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule