[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset to state A
    always @(posedge clk) begin
        if (areset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state; // Default to current state
        case (current_state)
            A: begin
                if (x) begin
                    next_state = B;
                end
            end
            B: begin
                // Remain in B regardless of x
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            A: z = x; // Output z = 1 when x = 1
            B: z = ~x; // Output z = 1 when x = 0
            default: z = 1'b0; // Default case
        endcase
    end

endmodule
```
[DONE]