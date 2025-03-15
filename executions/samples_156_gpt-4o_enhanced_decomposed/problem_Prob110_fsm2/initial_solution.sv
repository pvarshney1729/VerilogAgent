module TopModule(
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);

    typedef enum logic {OFF = 1'b0, ON = 1'b1} state_t;
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            OFF: next_state = (j) ? ON : OFF;
            ON:  next_state = (k) ? OFF : ON;
            default: next_state = OFF;
        endcase
    end

    // Output logic
    assign out = (current_state == ON);

endmodule