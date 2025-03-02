module TopModule (
    input logic clk,
    input logic reset,
    input logic input_signal,
    output logic output_signal
);

    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_0: next_state = input_signal ? STATE_1 : STATE_0;
            STATE_1: next_state = input_signal ? STATE_2 : STATE_0;
            STATE_2: next_state = input_signal ? STATE_3 : STATE_0;
            STATE_3: next_state = input_signal ? STATE_3 : STATE_0;
            default: next_state = STATE_0;
        endcase
    end

    // Output logic (Moore machine)
    always @(*) begin
        case (current_state)
            STATE_0: output_signal = 1'b0;
            STATE_1: output_signal = 1'b1;
            STATE_2: output_signal = 1'b1;
            STATE_3: output_signal = 1'b1;
            default: output_signal = 1'b0;
        endcase
    end

endmodule