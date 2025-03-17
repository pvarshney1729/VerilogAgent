module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    typedef enum logic [0:0] {B = 1'b0, A = 1'b1} state_t;
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            B: next_state = (in == 1'b0) ? A : B;
            A: next_state = (in == 1'b0) ? B : A;
            default: next_state = B; // Default state
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            B: out = 1'b1;
            A: out = 1'b0;
            default: out = 1'b0; // Default output
        endcase
    end

endmodule