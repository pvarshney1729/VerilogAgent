module TopModule(
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE   = 2'b00,
        ENABLE = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [2:0] shift_counter;

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= ENABLE;
            shift_counter <= 3'b100; // Initialize counter to 4
        end else begin
            current_state <= next_state;
            if (current_state == ENABLE) begin
                if (shift_counter != 3'b000) begin
                    shift_counter <= shift_counter - 1;
                end
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (reset)
                    next_state = ENABLE;
                else
                    next_state = IDLE;
            end
            ENABLE: begin
                if (shift_counter == 3'b000)
                    next_state = IDLE;
                else
                    next_state = ENABLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        shift_ena = (current_state == ENABLE);
    end

endmodule