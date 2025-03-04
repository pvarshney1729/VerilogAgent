module TopModule (
    input logic clk,
    input logic reset,
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

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                A: out <= 1'b0;
                B: out <= 1'b0;
                C: out <= 1'b0;
                D: out <= 1'b1;
            endcase
        end
    end

    always_comb begin
        case (current_state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A; // Default to state A for safety
        endcase
    end

endmodule