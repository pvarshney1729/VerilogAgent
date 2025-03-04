module TopModule (
    input  logic clk,   // Clock signal, positive edge triggered
    input  logic reset, // Synchronous active-high reset
    input  logic w,     // Input signal for state transition
    output logic z      // Output signal, reflects current state's output value
);

    // State encoding
    localparam [2:0] STATE_A = 3'b000,
                     STATE_B = 3'b001,
                     STATE_C = 3'b010,
                     STATE_D = 3'b011,
                     STATE_E = 3'b100,
                     STATE_F = 3'b101;

    // State variable
    logic [2:0] current_state, next_state;

    // Initial state
    initial begin
        current_state = STATE_A;
    end

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (w) ? STATE_B : STATE_A;
            STATE_B: next_state = (w) ? STATE_C : STATE_D;
            STATE_C: next_state = (w) ? STATE_E : STATE_D;
            STATE_D: next_state = (w) ? STATE_F : STATE_A;
            STATE_E: next_state = (w) ? STATE_E : STATE_D;
            STATE_F: next_state = (w) ? STATE_C : STATE_D;
            default: next_state = STATE_A; // Safe state fallback
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_A, STATE_B, STATE_C, STATE_D: z = 1'b0;
            STATE_E, STATE_F: z = 1'b1;
            default: z = 1'b0; // Default output for safety
        endcase
    end

endmodule