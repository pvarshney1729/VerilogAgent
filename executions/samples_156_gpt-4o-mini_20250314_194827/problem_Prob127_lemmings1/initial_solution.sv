module state_machine (
    input logic clk,
    input logic reset,
    output logic walking_left,
    output logic walking_right
);

    typedef enum logic [1:0] {
        S_IDLE = 2'b00,
        S_WALK_LEFT = 2'b01,
        S_WALK_RIGHT = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S_IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S_IDLE: next_state = S_WALK_LEFT; // Example transition
            S_WALK_LEFT: next_state = S_WALK_RIGHT; // Example transition
            S_WALK_RIGHT: next_state = S_IDLE; // Example transition
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic based on current state
    assign walking_left = (current_state == S_WALK_LEFT);
    assign walking_right = (current_state == S_WALK_RIGHT);

endmodule