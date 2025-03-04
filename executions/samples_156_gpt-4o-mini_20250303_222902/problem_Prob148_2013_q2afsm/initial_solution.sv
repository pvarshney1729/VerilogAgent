module TopModule (
    input logic clk,       // Clock signal, positive-edge triggered
    input logic resetn,    // Active-low synchronous reset
    input logic [2:0] r,   // 3-bit request input
    output logic [2:0] g    // 3-bit grant output
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
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
                if (r[2]) 
                    next_state = D;
                else 
                    next_state = A;
            end
            default: next_state = A;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (!resetn) 
            current_state <= A;
        else 
            current_state <= next_state;
    end

    // Grant output logic
    always @(*) begin
        g = 3'b000; // Default to no grants
        case (current_state)
            B: g[0] = 1'b1; // Grant for state B
            C: g[1] = 1'b1; // Grant for state C
            D: g[2] = 1'b1; // Grant for state D
            default: g = 3'b000; // No grants
        endcase
    end

endmodule