```verilog
module TopModule (
    input wire clk,        // Clock signal, active on rising edge
    input wire areset,     // Asynchronous reset, active high
    input wire in,         // Input signal
    output reg out         // Output signal, 1 bit
);

    reg state; // 0: State A, 1: State B

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b1; // State B
            out <= 1'b1;
        end else begin
            case (state)
                1'b0: // State A
                    if (in == 1'b0) begin
                        state <= 1'b1; // Transition to State B
                        out <= 1'b1;
                    end
                1'b1: // State B
                    if (in == 1'b0) begin
                        state <= 1'b0; // Transition to State A
                        out <= 1'b0;
                    end
            endcase
        end
    end

endmodule
```