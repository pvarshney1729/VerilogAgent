module TopModule(
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count; // Counts the number of times w is 1
    logic [1:0] cycle_count; // Counts the number of cycles in STATE_B

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                cycle_count <= cycle_count + 1;
                if (w) begin
                    w_count <= w_count + 1;
                end
                if (cycle_count == 2'b10) begin
                    z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
                    w_count <= 2'b00; // Reset w_count for the next set of cycles
                    cycle_count <= 2'b00; // Reset cycle_count for the next set of cycles
                end
            end else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B: begin
                if (cycle_count == 2'b10) begin
                    next_state = STATE_B; // Continue in STATE_B to check next set of cycles
                end else begin
                    next_state = STATE_B;
                end
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule