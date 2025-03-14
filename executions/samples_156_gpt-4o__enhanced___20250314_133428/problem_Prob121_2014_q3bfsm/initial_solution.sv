```verilog
module TopModule (
    input logic clk,          // Clock signal
    input logic reset,        // Synchronous active high reset
    input logic x,            // Input signal
    output logic z            // Output signal
);

    // State register
    logic [2:0] state;

    // Sequential logic for state transition and output
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // Initial state on reset
            z <= 0;
        end else begin
            case (state)
                3'b000: begin
                    state <= (x == 1'b0) ? 3'b000 : 3'b001;
                    z <= 0;
                end
                3'b001: begin
                    state <= (x == 1'b0) ? 3'b001 : 3'b100;
                    z <= 0;
                end
                3'b010: begin
                    state <= (x == 1'b0) ? 3'b010 : 3'b001;
                    z <= 0;
                end
                3'b011: begin
                    state <= (x == 1'b0) ? 3'b001 : 3'b010;
                    z <= 1;
                end
                3'b100: begin
                    state <= (x == 1'b0) ? 3'b011 : 3'b100;
                    z <= 1;
                end
                default: begin
                    state <= 3'b000; // Default to initial state
                    z <= 0;
                end
            endcase
        end
    end

endmodule
```