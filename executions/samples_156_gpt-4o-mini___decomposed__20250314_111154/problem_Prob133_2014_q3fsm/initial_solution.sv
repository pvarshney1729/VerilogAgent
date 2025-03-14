module TopModule (
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    typedef enum logic [1:0] {A, B} state_t;
    state_t current_state, next_state;
    logic [2:0] w_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            w_count <= 3'b000;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == B) begin
                w_count <= {w_count[1:0], w}; // Shift in the new w value
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            A: begin
                if (s) begin
                    next_state = B;
                    w_count = 3'b000; // Reset the count when entering state B
                end
            end
            B: begin
                next_state = B; // Stay in state B for 3 cycles
            end
            default: next_state = A;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            z <= 1'b0; // Reset output z
        end else if (current_state == B) begin
            // Check if w was 1 in exactly two of the last three clock cycles
            if (w_count == 3'b011 || w_count == 3'b101 || w_count == 3'b110) begin
                z <= 1'b1; // Set z to 1 if exactly two w's are 1
            end else begin
                z <= 1'b0; // Otherwise, set z to 0
            end
        end
    end

endmodule