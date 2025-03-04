module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    typedef enum logic {A = 1'b0, B = 1'b1} state_t;
    state_t current_state, next_state;

    // Asynchronous reset to state B
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            A: begin
                out = 1'b0;
                if (in) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            B: begin
                out = 1'b1;
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            default: begin
                out = 1'b0;
                next_state = A; // Default state
            end
        endcase
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly