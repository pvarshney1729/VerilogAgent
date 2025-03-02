module fsm_example (
    input logic clk,
    input logic reset,
    input logic start,
    output logic done
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: begin
                if (start) 
                    next_state = S1;
                else 
                    next_state = S0;
            end
            S1: begin
                next_state = S2;
            end
            S2: begin
                next_state = S3;
            end
            S3: begin
                next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    assign done = (current_state == S3);

endmodule