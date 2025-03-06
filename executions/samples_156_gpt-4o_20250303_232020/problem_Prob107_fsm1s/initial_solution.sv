module TopModule (
    input logic clk,    // Clock input, assumes positive edge-triggered
    input logic reset,  // Active-high synchronous reset
    input logic in,     // Single-bit input signal
    output logic out    // Single-bit output signal
);

    typedef enum logic [1:0] {
        STATE_B = 2'b00, // State B with output set to 1
        STATE_A = 2'b01  // State A with output set to 0
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            STATE_B: begin
                out = 1'b1;
                if (in == 1'b0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_A: begin
                out = 1'b0;
                if (in == 1'b0) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
        endcase
    end

endmodule