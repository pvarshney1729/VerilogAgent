module TopModule(
    input  logic clk,    // 1-bit clock input
    input  logic reset,  // 1-bit active high synchronous reset
    input  logic s,      // 1-bit input for state transition
    input  logic w,      // 1-bit input for counting
    output logic z       // 1-bit output
);

    typedef enum logic [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_counter;
    logic [1:0] cycle_counter;

    // State Register
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            w_counter <= 2'b00;
            cycle_counter <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                if (cycle_counter == 2'b10) begin
                    z <= (w_counter == 2'b10) ? 1'b1 : 1'b0;
                    w_counter <= 2'b00;
                    cycle_counter <= 2'b00;
                end else begin
                    cycle_counter <= cycle_counter + 1;
                    if (w) begin
                        w_counter <= w_counter + 1;
                    end
                end
            end
        end
    end

    // Next State Logic
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
                next_state = STATE_B;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule