[BEGIN]
module TopModule (
    input  logic clk,
    input  logic aresetn,
    input  logic x,
    output logic z
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: if (x) next_state = S1; else next_state = S0;
            S1: if (!x) next_state = S2; else next_state = S1;
            S2: if (x) next_state = S1; else next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S0: z = 1'b0;
            S1: z = 1'b0;
            S2: z = x;
            default: z = 1'b0;
        endcase
    end

endmodule
[DONE]