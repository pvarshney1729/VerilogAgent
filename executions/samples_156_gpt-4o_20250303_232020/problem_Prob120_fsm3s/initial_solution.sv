module TopModule (
    input logic clk,           // Clock signal, positive edge triggered
    input logic reset,         // Synchronous active high reset
    input logic in,            // FSM input signal
    output logic out           // FSM output signal
);

    // State encoding using binary representation
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;
            out <= 1'b0;
        end else begin
            case (state)
                STATE_A: begin
                    state <= in ? STATE_B : STATE_A;
                    out <= 1'b0;
                end
                STATE_B: begin
                    state <= in ? STATE_B : STATE_C;
                    out <= 1'b0;
                end
                STATE_C: begin
                    state <= in ? STATE_D : STATE_A;
                    out <= 1'b0;
                end
                STATE_D: begin
                    state <= in ? STATE_B : STATE_C;
                    out <= 1'b1;
                end
                default: begin
                    state <= STATE_A; // Fallback to a known state
                    out <= 1'b0;
                end
            endcase
        end
    end

endmodule