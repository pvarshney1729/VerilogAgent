module TopModule (
    input logic clk,      // Clock signal, positive edge-triggered
    input logic reset,    // Synchronous active high reset
    input logic in,       // 1-bit input signal
    output logic out      // 1-bit output signal
);

// State encoding
localparam logic [1:0] STATE_A = 2'b00, 
                       STATE_B = 2'b01, 
                       STATE_C = 2'b10, 
                       STATE_D = 2'b11;

logic [1:0] current_state, next_state;

// State transition and output logic
always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_A;
        out <= 0;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_A: begin
            next_state = (in) ? STATE_B : STATE_A;
            out = 0;
        end
        STATE_B: begin
            next_state = (in) ? STATE_B : STATE_C;
            out = 0;
        end
        STATE_C: begin
            next_state = (in) ? STATE_D : STATE_A;
            out = 0;
        end
        STATE_D: begin
            next_state = (in) ? STATE_B : STATE_C;
            out = 1;
        end
        default: begin
            next_state = STATE_A;
            out = 0;
        end
    endcase
end

endmodule