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
    logic [1:0] cycle_count; // Counter for the number of cycles in state B
    logic [1:0] w_count;     // Counter for the number of times w is 1

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
                    cycle_count <= 2'b00;
                    if (w_count == 2'b10) begin
                        z <= 1'b1;
                    end else begin
                        z <= 1'b0;
                    end
                    w_count <= 2'b00;
                end
            end else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (s) next_state = STATE_B;
                else next_state = STATE_A;
            end
            STATE_B: begin
                next_state = STATE_B; // Remain in STATE_B
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule