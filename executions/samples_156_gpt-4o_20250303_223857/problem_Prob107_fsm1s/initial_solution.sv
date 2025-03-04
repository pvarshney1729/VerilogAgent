module TopModule (
    input  logic clk,    // Clock signal, assumed positive edge-triggered
    input  logic reset,  // Synchronous active-high reset
    input  logic in,     // Single-bit input
    output logic out     // Single-bit output, registered
);

    // Define state encoding
    localparam logic STATE_B = 1'b0, STATE_A = 1'b1;

    // State register
    logic current_state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B; // Reset state
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    // Combinational logic for state transitions and output
    always @(*) begin
        case (current_state)
            STATE_B: begin
                out = 1'b1;
                next_state = (in == 1'b0) ? STATE_A : STATE_B;
            end
            STATE_A: begin
                out = 1'b0;
                next_state = (in == 1'b0) ? STATE_B : STATE_A;
            end
            default: begin
                out = 1'b1;           // Default to STATE_B output
                next_state = STATE_B; // Default to STATE_B
            end
        endcase
    end

endmodule