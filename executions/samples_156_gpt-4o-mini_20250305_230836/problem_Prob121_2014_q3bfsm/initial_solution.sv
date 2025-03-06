[BEGIN]
```verilog
module TopModule (
    input logic clk,        // Clock input, positive edge-triggered
    input logic reset,      // Synchronous active-high reset
    input logic x,          // Input signal
    output logic z          // Output signal
);
    logic [2:0] y;         // State representation

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            y <= 3'b000;   // Reset state
            z <= 1'b0;     // Reset output
        end else begin
            case (y)
                3'b000: begin
                    y <= (x) ? 3'b001 : 3'b000;
                    z <= 1'b0;
                end
                3'b001: begin
                    y <= (x) ? 3'b100 : 3'b001;
                    z <= 1'b0;
                end
                3'b010: begin
                    y <= (x) ? 3'b001 : 3'b010;
                    z <= 1'b0;
                end
                3'b011: begin
                    y <= (x) ? 3'b010 : 3'b001;
                    z <= 1'b1;
                end
                3'b100: begin
                    y <= (x) ? 3'b100 : 3'b011;
                    z <= 1'b1;
                end
                default: begin
                    y <= 3'b000; // Default case to avoid latches
                    z <= 1'b0;
                end
            endcase
        end
    end

    // Combinational logic for output z based on current state
    always @(*) begin
        case (y)
            3'b000: z = 1'b0;
            3'b001: z = 1'b0;
            3'b010: z = 1'b0;
            3'b011: z = 1'b1;
            3'b100: z = 1'b1;
            default: z = 1'b0; // Default case
        endcase
    end
endmodule
```
[DONE]