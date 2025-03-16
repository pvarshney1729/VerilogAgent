module TopModule(
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);
    typedef enum logic [1:0] {A, B} state_t;
    state_t current_state, next_state;
    logic [2:0] w_count; // Counter for w = 1 occurrences
    logic [1:0] cycle;   // Cycle counter for three clock cycles

    // Sequential logic for state transitions and output
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            z <= 1'b0;
            w_count <= 3'b000;
            cycle <= 2'b00;
        end else begin
            current_state <= next_state;

            if (current_state == B) begin
                if (cycle < 3) begin
                    if (w) begin
                        w_count <= w_count + 1; // Increment count if w = 1
                    end
                    cycle <= cycle + 1; // Increment cycle count
                end else begin
                    z <= (w_count == 3'b010) ? 1'b1 : 1'b0; // Set z based on count
                    // Reset for the next three cycles
                    w_count <= 3'b000;
                    cycle <= 2'b00;
                end
            end
        end
    end

    // Combinational logic for next state determination
    always @(*) begin
        case (current_state)
            A: begin
                if (s) begin
                    next_state = B; // Transition to State B
                    w_count = 3'b000; // Reset count when moving to State B
                    cycle = 2'b00; // Reset cycle count
                end else begin
                    next_state = A; // Stay in State A
                end
            end
            B: begin
                next_state = B; // Stay in State B until cycles are processed
            end
            default: next_state = A; // Default to State A
        endcase
    end
endmodule