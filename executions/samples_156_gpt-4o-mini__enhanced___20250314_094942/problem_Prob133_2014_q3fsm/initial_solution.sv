module TopModule (
    input logic clk,         // Clock input, active on rising edge
    input logic reset,       // Synchronous active-high reset
    input logic s,          // Input signal, single bit
    input logic w,          // Input signal, single bit
    output logic z          // Output signal, single bit
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] count_w; // Counter for w = 1 occurrences

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            z <= 1'b0;
            count_w <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == B) begin
                if (count_w < 2'b11) begin
                    count_w <= count_w + w; // Increment counter if w = 1
                end
            end
            if (next_state == A) begin
                z <= 1'b0; // Reset z when returning to state A
            end else if (count_w == 2'b10) begin
                z <= 1'b1; // Set z if exactly two w = 1
            end else begin
                z <= 1'b0; // Otherwise, set z to 0
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: begin
                if (s) begin
                    next_state = B;
                    count_w = 2'b00; // Reset counter when moving to state B
                end else begin
                    next_state = A;
                end
            end
            B: begin
                next_state = B; // Stay in state B
            end
            default: begin
                next_state = A; // Default to state A
            end
        endcase
    end

endmodule