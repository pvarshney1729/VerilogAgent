module fsm_example (
    input logic clk,
    input logic rst_n,
    input logic start,
    output logic z
);
    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (!rst_n) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: begin
                if (start) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
                z = 1'b0;
            end
            S1: begin
                next_state = S2;
                z = 1'b1;
            end
            S2: begin
                next_state = S0;
                z = 1'b0;
            end
            default: begin
                next_state = S0;
                z = 1'b0;
            end
        endcase
    end
endmodule