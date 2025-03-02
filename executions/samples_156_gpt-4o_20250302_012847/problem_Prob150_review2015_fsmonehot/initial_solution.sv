module fsm_one_hot (
    input logic clk,
    input logic reset,
    input logic [3:0] input_signal,
    output logic [9:0] state,
    output logic output_signal
);

    // State encoding using one-hot
    typedef enum logic [9:0] {
        S0 = 10'b0000000001,
        S1 = 10'b0000000010,
        S2 = 10'b0000000100,
        S3 = 10'b0000001000,
        S4 = 10'b0000010000,
        S5 = 10'b0000100000,
        S6 = 10'b0001000000,
        S7 = 10'b0010000000,
        S8 = 10'b0100000000,
        S9 = 10'b1000000000
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = (input_signal == 4'b0001) ? S1 : S0;
            S1: next_state = (input_signal == 4'b0010) ? S2 : S1;
            S2: next_state = (input_signal == 4'b0011) ? S3 : S2;
            S3: next_state = (input_signal == 4'b0100) ? S4 : S3;
            S4: next_state = (input_signal == 4'b0101) ? S5 : S4;
            S5: next_state = (input_signal == 4'b0110) ? S6 : S5;
            S6: next_state = (input_signal == 4'b0111) ? S7 : S6;
            S7: next_state = (input_signal == 4'b1000) ? S8 : S7;
            S8: next_state = (input_signal == 4'b1001) ? S9 : S8;
            S9: next_state = (input_signal == 4'b1010) ? S0 : S9;
            default: next_state = S0; // Handle illegal states
        endcase
    end

    // Output logic
    always @(*) begin
        output_signal = (current_state == S9);
    end

    // Assign current state to output
    assign state = current_state;

endmodule