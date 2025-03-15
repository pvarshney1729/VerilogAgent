module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic x,
    output logic z
);

    // State encoding
    typedef enum logic [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: next_state = (x) ? S1 : S0;
            S1: next_state = (x) ? S4 : S1;
            S2: next_state = (x) ? S1 : S2;
            S3: next_state = (x) ? S2 : S1;
            S4: next_state = (x) ? S4 : S3;
            default: next_state = S0;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S0, S1, S2: z = 1'b0;
            S3, S4: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule