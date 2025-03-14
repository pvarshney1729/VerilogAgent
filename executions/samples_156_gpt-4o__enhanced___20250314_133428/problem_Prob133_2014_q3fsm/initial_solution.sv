module TopModule (
    input logic clk,         // Clock signal, active on the rising edge
    input logic reset,       // Synchronous active high reset
    input logic s,           // State transition input (1 bit)
    input logic w,           // FSM input to be evaluated (1 bit)
    output logic z           // FSM output (1 bit)
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count; // Counter for w = 1 occurrences
    logic [1:0] cycle_count; // Counter for cycles in state B

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
                cycle_count <= cycle_count + 1;
                if (w) begin
                    w_count <= w_count + 1;
                end
                if (cycle_count == 2'b10) begin
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
                if (cycle_count == 2'b10) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule