module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset to state A
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition logic
    always_comb begin
        case (current_state)
            A: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
            C: begin
                if (in) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            D: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
            default: begin
                next_state = A; // Safe state recovery
            end
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            A, B, C: out = 0;
            D: out = 1;
            default: out = 0; // Default output
        endcase
    end

endmodule