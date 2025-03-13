```verilog
[BEGIN]
module TopModule (
    input logic clk,           // Clock signal, positive edge-triggered
    input logic resetn,        // Active-low synchronous reset
    input logic [2:0] r,       // 3-bit request input vector
    output logic [2:0] g        // 3-bit grant output vector
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State flip-flops
    always @(posedge clk) begin
        if (~resetn)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: begin
                if (r[0])
                    next_state = B;
                else if (r[1])
                    next_state = C;
                else if (r[2])
                    next_state = D;
                else
                    next_state = A;
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
            D: begin
                next_state = A; // D has no persistence, returns to A
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            A: g = 3'b000;
            B: g = 3'b001;
            C: g = 3'b010;
            D: g = 3'b100;
            default: g = 3'b000;
        endcase
    end

endmodule
[DONE]
```