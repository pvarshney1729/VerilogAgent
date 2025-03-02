module TopModule (
    input logic clk,
    input logic reset,
    input logic w,
    output logic z
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [2:0] count_w;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
            count_w <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == S1) begin
                count_w <= {count_w[1:0], w}; // Shift in the current w value
            end
        end
    end

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: next_state = S1; // Move to counting state
            S1: next_state = S2; // Move to output state after counting
            S2: next_state = S0; // Reset to initial state
            default: next_state = S0;
        endcase
    end

    // Output logic for z based on count_w
    always @(*) begin
        z = (count_w[0] + count_w[1] + count_w[2] == 3'b010); // Check if exactly two are high
    end

endmodule