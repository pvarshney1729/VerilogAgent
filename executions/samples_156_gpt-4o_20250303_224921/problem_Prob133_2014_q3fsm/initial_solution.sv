module TopModule (
    input  logic clk,       // Clock signal (assumed to be positive edge-triggered)
    input  logic reset,     // Synchronous active-high reset
    input  logic s,         // State control input
    input  logic w,         // Input to be monitored over three cycles
    output logic z          // Output set based on monitoring condition
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] cycle_count;
    logic [1:0] w_count;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            cycle_count <= 2'b00;
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                if (cycle_count == 2'b11) begin
                    z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
                end else begin
                    z <= 1'b0;
                end
            end else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic and cycle counting
    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (!s) begin
                    next_state = STATE_A;
                end else if (cycle_count == 2'b11) begin
                    next_state = STATE_A;
                end
            end
        endcase
    end

    // Cycle and w counting logic
    always_ff @(posedge clk) begin
        if (reset || current_state == STATE_A) begin
            cycle_count <= 2'b00;
            w_count <= 2'b00;
        end else if (current_state == STATE_B) begin
            cycle_count <= cycle_count + 1;
            if (w) begin
                w_count <= w_count + 1;
            end
        end
    end

endmodule