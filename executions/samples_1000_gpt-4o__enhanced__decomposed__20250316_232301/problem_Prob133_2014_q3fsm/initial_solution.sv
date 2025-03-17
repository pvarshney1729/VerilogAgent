module TopModule(
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
    logic [1:0] cycle_count; // Counter for cycles in state B
    logic [1:0] w_count;     // Counter for 'w' being 1

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            cycle_count <= 2'b00;
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                if (cycle_count < 2'b11) begin
                    cycle_count <= cycle_count + 1;
                    if (w) begin
                        w_count <= w_count + 1;
                    end
                end else begin
                    cycle_count <= 2'b00; // Reset cycle count after 3 cycles
                    w_count <= 2'b00;     // Reset w count after 3 cycles
                    z <= (w_count == 2'b10) ? 1'b1 : 1'b0; // Set z based on w_count
                end
            end else begin
                cycle_count <= 2'b00;
                w_count <= 2'b00;
                z <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (s == 1'b1)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (cycle_count == 2'b11)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule