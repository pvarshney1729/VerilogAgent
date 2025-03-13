[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic resetn,
    input logic [2:0] r,
    output logic [2:0] g
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State flip-flops
    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state; // Default to hold current state
        case (current_state)
            A: begin
                if (r[0]) 
                    next_state = B;
                else if (r[1]) 
                    next_state = C;
                else if (r[2]) 
                    next_state = A; // Stay in A if r[2] is high
            end
            B: begin
                if (r[0]) 
                    next_state = B;
                else 
                    next_state = A;
            end
            C: begin
                if (r[1]) 
                    next_state = C;
                else 
                    next_state = A;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        g = 3'b000; // Default output
        case (current_state)
            B: g[0] = 1'b1; // Grant for device 0
            C: g[1] = 1'b1; // Grant for device 1
            default: g = 3'b000; // No grants
        endcase
    end

endmodule
```
[DONE]