```
[BEGIN]
module TopModule (
    input logic clk,            // Clock signal (1 bit)
    input logic areset,        // Asynchronous reset signal (1 bit)
    input logic in,            // Input signal (1 bit)
    output logic out           // Output signal (1 bit)
);
    
    logic current_state; // 0 for state A, 1 for state B

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 1'b1; // Reset to state B
        end else begin
            case (current_state)
                1'b0: begin // State A
                    if (in == 1'b0)
                        current_state <= 1'b1; // Transition to B
                end
                1'b1: begin // State B
                    if (in == 1'b0)
                        current_state <= 1'b0; // Transition to A
                end
            endcase
        end
    end

    always_comb begin
        out = current_state; // Output is the current state (1 for B, 0 for A)
    end
endmodule
[DONE]
```