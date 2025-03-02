module fsm (
    input logic clk,
    input logic reset,
    input logic a,
    input logic b,
    output logic Y0,
    output logic z
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
            S0: next_state = (a) ? S1 : S0;
            S1: next_state = (b) ? S2 : S1;
            S2: next_state = S3;
            S3: next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    assign Y0 = (current_state == S2);
    assign z = (current_state == S3);

endmodule