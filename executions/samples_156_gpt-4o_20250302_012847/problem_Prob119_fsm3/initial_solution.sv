module moore_state_machine (
    input logic clk,
    input logic reset_n, // Active low asynchronous reset
    input logic in,
    output logic out
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S3 : S0;
            default: next_state = S0;
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S0: out = 1'b0;
            S1: out = 1'b0;
            S2: out = 1'b0;
            S3: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule