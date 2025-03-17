module TopModule (
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count; // Counter for w = 1 occurrences
    logic [1:0] cycle_count; // Counter for clock cycles in state B

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = current_state; // Default state transition
        z = 1'b0; // Default output

        case (current_state)
            STATE_A: begin
                if (s == 1'b1) begin
                    next_state = STATE_B;
                    w_count = 2'b00;
                    cycle_count = 2'b00;
                end
            end

            STATE_B: begin
                if (cycle_count < 2'b10) begin
                    cycle_count = cycle_count + 1'b1;
                    if (w == 1'b1) begin
                        w_count = w_count + 1'b1;
                    end
                end else begin
                    if (w_count == 2'b10) begin
                        z = 1'b1;
                    end
                    next_state = STATE_A; // Return to state A after 3 cycles
                end
            end
        endcase
    end

endmodule