module TopModule (
    input logic clk,       // Clock signal, positive edge-triggered
    input logic reset,     // Synchronous active high reset
    input logic s,         // Input signal used in state A
    input logic w,         // Input signal evaluated over three clock cycles in state B
    output logic z         // Output signal, determined after evaluation of w
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count; // Counter for 'w' being 1 in State B
    logic [1:0] cycle_count; // Counter for clock cycles in State B

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            z <= 1'b0;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
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