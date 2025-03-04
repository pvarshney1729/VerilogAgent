module TopModule (
    input  logic clk,       // Clock signal, triggers on the rising edge
    input  logic reset,     // Asynchronous reset signal, active high
    input  logic w,         // Input signal
    output logic z          // Output signal
);

    // State encoding
    parameter STATE_A = 3'b000;
    parameter STATE_B = 3'b001;
    parameter STATE_C = 3'b010;
    parameter STATE_D = 3'b011;
    parameter STATE_E = 3'b100;
    parameter STATE_F = 3'b101;

    logic [2:0] current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_A: next_state = (w == 1'b0) ? STATE_B : STATE_A;
            STATE_B: next_state = (w == 1'b0) ? STATE_C : STATE_D;
            STATE_C: next_state = (w == 1'b0) ? STATE_E : STATE_D;
            STATE_D: next_state = (w == 1'b0) ? STATE_F : STATE_A;
            STATE_E: next_state = (w == 1'b0) ? STATE_E : STATE_D;
            STATE_F: next_state = (w == 1'b0) ? STATE_C : STATE_D;
            default: next_state = STATE_A; // Fail-safe for undefined states
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            STATE_E, STATE_F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule