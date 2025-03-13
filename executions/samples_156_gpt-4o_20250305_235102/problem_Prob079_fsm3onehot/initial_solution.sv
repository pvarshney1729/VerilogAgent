```verilog
[BEGIN]
module TopModule (
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out,
    input logic clk,
    input logic reset_n
);

    always @(posedge clk) begin
        if (!reset_n) begin
            next_state <= 4'b0001; // Reset to State A
            out <= 1'b0;
        end else begin
            case (state)
                4'b0001: begin // State A
                    if (in) next_state <= 4'b0010; // Go to B
                    else next_state <= 4'b0001;    // Stay in A
                    out <= 1'b0;
                end
                4'b0010: begin // State B
                    if (in) next_state <= 4'b0010; // Stay in B
                    else next_state <= 4'b0100;    // Go to C
                    out <= 1'b0;
                end
                4'b0100: begin // State C
                    if (in) next_state <= 4'b1000; // Go to D
                    else next_state <= 4'b0001;    // Go to A
                    out <= 1'b0;
                end
                4'b1000: begin // State D
                    if (in) next_state <= 4'b0010; // Go to B
                    else next_state <= 4'b0100;    // Go to C
                    out <= 1'b1;
                end
                default: begin // Invalid state handling
                    next_state <= 4'b0001; // Default to A
                    out <= 1'b0;
                end
            endcase
        end
    end

endmodule
[DONE]
```