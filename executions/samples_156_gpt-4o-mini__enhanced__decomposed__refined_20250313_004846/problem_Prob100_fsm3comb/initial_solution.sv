```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic rst_n,
    input logic in,
    input logic [1:0] state,
    output logic [1:0] next_state,
    output logic out
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        next_state <= 2'b00;  // Initial state A on reset
        out <= 1'b0;
    end else begin
        case (state)
            2'b00: begin  // State A
                if (in) next_state <= 2'b01;  // Transition to B
                else next_state <= 2'b00;     // Stay in A
                out <= 1'b0;
            end
            2'b01: begin  // State B
                if (in) next_state <= 2'b01;  // Stay in B
                else next_state <= 2'b10;     // Transition to C
                out <= 1'b0;
            end
            2'b10: begin  // State C
                if (in) next_state <= 2'b11;  // Transition to D
                else next_state <= 2'b00;     // Transition to A
                out <= 1'b0;
            end
            2'b11: begin  // State D
                if (in) next_state <= 2'b01;  // Transition to B
                else next_state <= 2'b10;     // Transition to C
                out <= 1'b1;
            end
            default: begin
                next_state <= 2'b00;  // Default to state A
                out <= 1'b0;
            end
        endcase
    end
end

endmodule
[DONE]
```