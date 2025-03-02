module fsm (
    input logic clk,
    input logic start,
    output logic [3:0] state_out
);

    // State encoding
    typedef enum logic [3:0] {
        S0 = 4'b0001,
        S1 = 4'b0010,
        S2 = 4'b0100,
        S3 = 4'b1000
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: next_state = start ? S1 : S0;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S0;
            default: next_state = S0;
        endcase
    end

    // State update logic
    always @(posedge clk) begin
        current_state <= next_state;
    end

    // Output logic
    assign state_out = current_state;

endmodule