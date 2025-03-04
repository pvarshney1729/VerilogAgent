module TopModule (
    input  logic clk,    // Clock input
    input  logic reset,  // Active-high synchronous reset
    input  logic s,      // Control signal for state transitions
    input  logic w,      // Input to be evaluated
    output logic z       // Output dependent on w evaluation
);

    typedef enum logic [1:0] {A, B} state_t;
    state_t state, next_state;

    logic [1:0] cycle_count; // Counts the clock cycles in state B
    logic [1:0] w_count;     // Counts occurrences of w = 1

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            cycle_count <= 2'b00;
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;
            if (state == B) begin
                cycle_count <= cycle_count + 1;
                if (w) w_count <= w_count + 1;
                if (cycle_count == 2'b10) begin
                    z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
                    cycle_count <= 2'b00;
                    w_count <= 2'b00;
                end
            end else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                if (!s) next_state = A;
                else next_state = B;
            end
            default: next_state = A;
        endcase
    end

endmodule