module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic reset,
    output logic Y1
);

    logic [2:0] state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // State A
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            3'b000: // State A
                if (w == 1'b0) next_state = 3'b001; // State B
                else next_state = 3'b000; // Remain in State A
            3'b001: // State B
                if (w == 1'b0) next_state = 3'b010; // State C
                else next_state = 3'b011; // State D
            3'b010: // State C
                if (w == 1'b0) next_state = 3'b100; // State E
                else next_state = 3'b011; // State D
            3'b011: // State D
                if (w == 1'b0) next_state = 3'b101; // State F
                else next_state = 3'b000; // State A
            3'b100: // State E
                if (w == 1'b0) next_state = 3'b100; // Remain in State E
                else next_state = 3'b011; // State D
            3'b101: // State F
                if (w == 1'b0) next_state = 3'b010; // State C
                else next_state = 3'b011; // State D
            default: // Handle invalid states
                next_state = 3'b000; // Default to State A
        endcase
    end

    // Output logic
    assign Y1 = state[1];

endmodule