module TopModule (
    input logic clk,
    input logic reset,
    input logic in_signal,
    output logic out_signal
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: begin
                if (in_signal) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                if (in_signal) 
                    next_state = C;
                else 
                    next_state = A;
            end
            C: begin
                if (in_signal) 
                    next_state = D;
                else 
                    next_state = A;
            end
            D: begin
                if (in_signal) 
                    next_state = A;
                else 
                    next_state = D;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    assign out_signal = (current_state == C);

endmodule