module state_machine (
    input logic clk,
    input logic reset,
    input logic start,
    output logic [1:0] state
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        FALLING = 2'b01,
        DIGGING = 2'b10,
        DONE = 2'b11
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
                if (start) begin
                    next_state = FALLING;
                end else begin
                    next_state = IDLE;
                end
            end
            FALLING: begin
                next_state = DIGGING;
            end
            DIGGING: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output the current state
    assign state = current_state;

endmodule