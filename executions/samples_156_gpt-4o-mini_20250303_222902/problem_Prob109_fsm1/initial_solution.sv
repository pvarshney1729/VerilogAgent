```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    typedef enum logic {A = 1'b0, B = 1'b1} state_t;
    state_t state, next_state;

    // Asynchronous reset to state B
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (in) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            B: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            default: begin
                next_state = B; // Default to state B
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0; // Default output
        endcase
    end

endmodule
```