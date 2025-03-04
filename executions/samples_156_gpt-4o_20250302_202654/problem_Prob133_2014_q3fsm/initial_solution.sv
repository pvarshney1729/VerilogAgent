module TopModule (
    input logic clk,          // Clock signal, positive edge triggered
    input logic reset,        // Active high synchronous reset
    input logic s,            // Input signal used for state transition from A
    input logic w,            // Input signal examined in state B
    output logic z            // Output signal, 1-bit wide
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count; // Counter for 'w' being 1
    logic [1:0] cycle_count; // Cycle counter for state B

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B && cycle_count == 2'b11) begin
                z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
            end else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (cycle_count == 2'b11) begin
                    next_state = STATE_B; // Remain in B to continue examination
                end
            end
        endcase
    end

    // Cycle and w count logic
    always_ff @(posedge clk) begin
        if (reset || current_state == STATE_A) begin
            cycle_count <= 2'b00;
            w_count <= 2'b00;
        end else if (current_state == STATE_B) begin
            cycle_count <= cycle_count + 1;
            if (w) begin
                w_count <= w_count + 1;
            end
            if (cycle_count == 2'b11) begin
                cycle_count <= 2'b00;
                w_count <= 2'b00;
            end
        end
    end

endmodule