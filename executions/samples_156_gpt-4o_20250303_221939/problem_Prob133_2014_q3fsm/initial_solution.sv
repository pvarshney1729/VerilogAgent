module TopModule (
    input logic clk,              // Clock signal, positive edge-triggered
    input logic reset,            // Active high synchronous reset
    input logic s,                // State control signal
    input logic w,                // Input signal to be monitored
    output logic z                // Output signal, set based on state machine logic
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] cycle_count;
    logic [1:0] w_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            z <= 1'b0;
            cycle_count <= 2'b00;
            w_count <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                if (cycle_count == 2'b11) begin
                    z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
                end
                cycle_count <= cycle_count + 1;
                if (w) begin
                    w_count <= w_count + 1;
                end
            end else begin
                z <= 1'b0;
                cycle_count <= 2'b00;
                w_count <= 2'b00;
            end
        end
    end

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
                if (!s) begin
                    next_state = STATE_A;
                end else if (cycle_count == 2'b11) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_B;
                end
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule