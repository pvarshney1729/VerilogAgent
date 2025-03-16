module TopModule(
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    // State encoding
    typedef enum logic [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t current_state, next_state;
    logic [1:0] cycle_count; // Counter for cycles in STATE_B
    logic [1:0] w_count;     // Counter for w = 1 occurrences

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            cycle_count <= 2'b00;
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        z = 1'b0;

        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                    cycle_count = 2'b00;
                    w_count = 2'b00;
                end
            end

            STATE_B: begin
                if (cycle_count == 2'b10) begin
                    if (w_count == 2'b10) begin
                        z = 1'b1;
                    end
                    next_state = STATE_B; // Continue in STATE_B
                    cycle_count = 2'b00;  // Reset cycle counter
                    w_count = 2'b00;      // Reset w counter
                end else begin
                    cycle_count = cycle_count + 1;
                    if (w) begin
                        w_count = w_count + 1;
                    end
                end
            end
        endcase
    end

endmodule