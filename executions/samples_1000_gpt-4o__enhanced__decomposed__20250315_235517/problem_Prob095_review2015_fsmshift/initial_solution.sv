module TopModule(
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    // State encoding
    typedef enum logic [0:0] {
        IDLE  = 1'b0,
        SHIFT = 1'b1
    } state_t;

    // State registers
    state_t state, next_state;
    logic [2:0] shift_counter;

    // State transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= SHIFT;
            shift_counter <= 3'd4; // Initialize counter to 4
            shift_ena <= 1'b1;     // Assert shift_ena
        end else begin
            state <= next_state;
            if (state == SHIFT) begin
                if (shift_counter != 3'd0) begin
                    shift_counter <= shift_counter - 1'b1;
                    shift_ena <= 1'b1;
                end else begin
                    shift_ena <= 1'b0;
                end
            end else begin
                shift_ena <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = SHIFT;
                end else begin
                    next_state = IDLE;
                end
            end
            SHIFT: begin
                if (shift_counter == 3'd0) begin
                    next_state = IDLE;
                end else begin
                    next_state = SHIFT;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule