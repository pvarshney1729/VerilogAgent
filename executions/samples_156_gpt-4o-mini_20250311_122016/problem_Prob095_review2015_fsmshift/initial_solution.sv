[BEGIN]
module TopModule (
    input logic clk,           // Clock signal, assumed to be 1-bit
    input logic reset,         // Active high synchronous reset, 1-bit
    output logic shift_ena     // Output to enable shifting, 1-bit
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE            = 3'b000,
        ENABLE_SHIFT_1  = 3'b001,
        ENABLE_SHIFT_2  = 3'b010,
        ENABLE_SHIFT_3  = 3'b011,
        ENABLE_SHIFT_4  = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Synchronous state transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_ena <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        // Default values
        next_state = current_state;
        shift_ena = 1'b0;

        case (current_state)
            IDLE: begin
                if (!reset) begin
                    next_state = ENABLE_SHIFT_1;
                end
            end
            ENABLE_SHIFT_1: begin
                shift_ena = 1'b1;
                next_state = ENABLE_SHIFT_2;
            end
            ENABLE_SHIFT_2: begin
                shift_ena = 1'b1;
                next_state = ENABLE_SHIFT_3;
            end
            ENABLE_SHIFT_3: begin
                shift_ena = 1'b1;
                next_state = ENABLE_SHIFT_4;
            end
            ENABLE_SHIFT_4: begin
                shift_ena = 1'b1;
                next_state = IDLE; // Return to IDLE after 4th cycle
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
[DONE]