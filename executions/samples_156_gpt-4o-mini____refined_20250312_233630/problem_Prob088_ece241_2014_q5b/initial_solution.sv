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

    // Combinational logic for next state and output
    always @(*) begin
        z = 1'b0; // Default output
        next_state = current_state; // Default next state
        case (current_state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1'b1;
                end
            end
            B: begin
                z = x ? 1'b0 : 1'b1; // Output logic for state B
            end
            default: begin
                next_state = A;
            end
        endcase
    end

endmodule
```
[DONE]