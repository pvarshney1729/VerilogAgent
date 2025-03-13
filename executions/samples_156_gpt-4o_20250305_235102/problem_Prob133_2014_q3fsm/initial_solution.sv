module TopModule(
    input  logic clk,      // Clock input, positive edge-triggered
    input  logic reset,    // Active high synchronous reset
    input  logic s,        // State transition control input
    input  logic w,        // Input to be monitored for FSM logic
    output logic z         // Output set conditionally on w's history
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count;
    logic [1:0] cycle_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
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
                    z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
                    w_count <= 2'b00;
                    cycle_count <= 2'b00;
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
                if (reset || (cycle_count == 2'b11)) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule