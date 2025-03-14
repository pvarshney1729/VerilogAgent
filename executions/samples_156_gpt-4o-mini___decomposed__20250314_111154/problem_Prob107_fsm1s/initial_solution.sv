module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);
    typedef enum logic [1:0] {B, A} state_t;
    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= B;
            out <= 1;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            B: begin
                out = 1;
                if (in) 
                    next_state = B;
                else 
                    next_state = A;
            end
            A: begin
                out = 0;
                if (in) 
                    next_state = A;
                else 
                    next_state = B;
            end
        endcase
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly