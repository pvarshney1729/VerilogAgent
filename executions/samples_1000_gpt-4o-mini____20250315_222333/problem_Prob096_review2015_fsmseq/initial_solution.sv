module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);
    typedef enum logic [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            S0: next_state = (data) ? S1 : S0;
            S1: next_state = (data) ? S2 : S0;
            S2: next_state = (data) ? S3 : S0;
            S3: next_state = (data) ? S4 : S0;
            S4: next_state = S4; // Stay in S4 after detecting 1101
            default: next_state = S0;
        endcase
    end

    assign start_shifting = (current_state == S4);

endmodule