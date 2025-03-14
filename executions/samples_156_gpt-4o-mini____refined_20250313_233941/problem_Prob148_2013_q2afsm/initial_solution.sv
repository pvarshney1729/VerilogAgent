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

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (!resetn) begin
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
                if (r[0]) begin
                    next_state = B;
                end else if (r[1]) begin
                    next_state = C;
                end else if (r[2]) begin
                    next_state = A; // Stay in A if only r[2] is high
                end
            end
            B: begin
                if (r[0]) begin
                    next_state = B; // Stay in B if r[0] is high
                end else begin
                    next_state = A; // Go back to A if r[0] is low
                end
            end
            C: begin
                if (r[1]) begin
                    next_state = C; // Stay in C if r[1] is high
                end else begin
                    next_state = A; // Go back to A if r[1] is low
                end
            end
            default: next_state = A; // Default case
        endcase
    end

    // Output logic
    always @(*) begin
        g = 3'b000; // Default output
        case (current_state)
            B: g[0] = 1'b1; // Grant to device 0
            C: g[1] = 1'b1; // Grant to device 1
            default: g[2] = 1'b0; // No grant for device 2
        endcase
    end

endmodule
```