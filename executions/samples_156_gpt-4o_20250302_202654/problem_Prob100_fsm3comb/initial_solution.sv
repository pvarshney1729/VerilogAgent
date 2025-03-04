module TopModule (
    input logic clk,                  // Clock signal for synchronous operation
    input logic reset,                // Asynchronous reset signal
    input logic in,                   // 1-bit input
    input logic [1:0] state,          // 2-bit current state
    output logic [1:0] next_state,    // 2-bit next state
    output logic out                  // 1-bit output
);

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        next_state <= 2'b00; // Reset to state A
        out <= 1'b0;
    end else begin
        case (state)
            2'b00: begin // State A
                next_state <= (in == 1'b0) ? 2'b00 : 2'b01;
                out <= 1'b0;
            end
            2'b01: begin // State B
                next_state <= (in == 1'b0) ? 2'b10 : 2'b01;
                out <= 1'b0;
            end
            2'b10: begin // State C
                next_state <= (in == 1'b0) ? 2'b00 : 2'b11;
                out <= 1'b0;
            end
            2'b11: begin // State D
                next_state <= (in == 1'b0) ? 2'b10 : 2'b01;
                out <= 1'b1;
            end
            default: begin
                next_state <= 2'b00; // Undefined states default to state A
                out <= 1'b0;
            end
        endcase
    end
end

endmodule