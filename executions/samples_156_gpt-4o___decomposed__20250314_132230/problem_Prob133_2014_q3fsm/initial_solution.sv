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

    // Counter for 'w' being 1
    logic [1:0] w_counter;
    logic [1:0] cycle_counter;
    logic z_next;

    // FSM state transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            w_counter <= 2'b00;
            cycle_counter <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                cycle_counter <= cycle_counter + 1'b1;
                if (w) begin
                    w_counter <= w_counter + 1'b1;
                end
                if (cycle_counter == 2'b10) begin
                    z <= (w_counter == 2'b10) ? 1'b1 : 1'b0;
                    w_counter <= 2'b00; // Reset count for the next 3 cycles
                    cycle_counter <= 2'b00; // Reset cycle counter
                end
            end else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (cycle_counter == 2'b10) begin
                    next_state = STATE_B; // Continue in STATE_B for next 3 cycles
                end
            end
        endcase
    end

endmodule