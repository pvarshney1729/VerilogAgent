module fsm_ps2_mouse (
    input logic clk,
    input logic reset,
    input logic data_in,
    output logic boundary_detected
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        START = 2'b01,
        DATA = 2'b10,
        STOP = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
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
            IDLE: begin
                if (data_in == 1'b1) begin
                    next_state = START;
                end else begin
                    next_state = IDLE;
                end
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (data_in == 1'b0) begin
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                end
            end
            STOP: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Boundary detection logic
    assign boundary_detected = (current_state == STOP);

endmodule