module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] state
);

    logic [9:0] current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= 10'b0000000001; // Initialize to state 0
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (current_state)
            10'b0000000001: next_state = 10'b0000000010; // State 0 to State 1
            10'b0000000010: next_state = 10'b0000000100; // State 1 to State 2
            10'b0000000100: next_state = 10'b0000001000; // State 2 to State 3
            10'b0000001000: next_state = 10'b0000010000; // State 3 to State 4
            10'b0000010000: next_state = 10'b0000100000; // State 4 to State 5
            10'b0000100000: next_state = 10'b0001000000; // State 5 to State 6
            10'b0001000000: next_state = 10'b0010000000; // State 6 to State 7
            10'b0010000000: next_state = 10'b0100000000; // State 7 to State 8
            10'b0100000000: next_state = 10'b1000000000; // State 8 to State 9
            10'b1000000000: next_state = 10'b0000000001; // State 9 to State 0
            default: next_state = 10'b0000000001; // Default to State 0
        endcase
    end

    assign state = current_state;

endmodule