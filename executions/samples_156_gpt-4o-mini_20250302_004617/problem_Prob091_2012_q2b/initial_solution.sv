module one_hot_fsm (
    input logic clk,
    input logic reset,
    input logic w,
    output logic Y1,
    output logic Y3
);

    // State encoding
    typedef enum logic [3:0] {
        S0 = 4'b0001,
        S1 = 4'b0010,
        S2 = 4'b0100,
        S3 = 4'b1000
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
            S0: next_state = (w) ? S1 : S0;
            S1: next_state = (w) ? S2 : S0;
            S2: next_state = (w) ? S3 : S0;
            S3: next_state = (w) ? S3 : S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    assign Y1 = (current_state == S1) || (current_state == S3);
    assign Y3 = (current_state == S2);

endmodule