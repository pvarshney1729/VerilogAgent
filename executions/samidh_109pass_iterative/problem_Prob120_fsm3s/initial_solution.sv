module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);
    // State encoding
    typedef enum logic [1:0] {A=2'b00, B=2'b01, C=2'b10, D=2'b11} state_t;
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                A: if (in) next_state <= B; else next_state <= A;
                B: if (in) next_state <= B; else next_state <= C;
                C: if (in) next_state <= D; else next_state <= A;
                D: if (in) next_state <= B; else next_state <= C;
            endcase
            // Output logic
            case (current_state)
                D: out <= 1'b1;
                default: out <= 1'b0;
            endcase
        end
    end
endmodule