module TopModule (
    input logic clk,          // Clock signal
    input logic reset,        // Active-high synchronous reset
    input logic in,           // One-bit input signal
    output logic out          // One-bit output signal
);

logic current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= 1'b0; // State B
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        1'b0: begin // State B
            out = 1'b1;
            if (in == 1'b0) next_state = 1'b1; // Transition to State A
            else next_state = 1'b0; // Remain in State B
        end
        1'b1: begin // State A
            out = 1'b0;
            if (in == 1'b0) next_state = 1'b0; // Transition to State B
            else next_state = 1'b1; // Remain in State A
        end
    endcase
end

endmodule