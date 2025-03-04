```verilog
module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic reset,        // Synchronous active high reset
    input logic x,            // Input signal x
    output logic z            // Output signal z
);

    logic [2:0] y;           // State register

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            y <= 3'b000;      // Reset state
            z <= 1'b0;        // Reset output
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
                    y <= 3'b000;  // Undefined states transition to 000
                    z <= 1'b0;
                end
            endcase
        end
    end

endmodule
```