module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);
    typedef enum logic [1:0] {A, B, C, D} state_t;
    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) 
            current_state <= A;
        else 
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A;
        endcase
    end

    always @(*) begin
        case (current_state)
            D: out = 1;
            default: out = 0;
        endcase
    end
endmodule