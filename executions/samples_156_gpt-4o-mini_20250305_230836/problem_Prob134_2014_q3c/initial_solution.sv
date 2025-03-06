```verilog
[BEGIN]
module TopModule (
    input logic clk,          // Clock signal, used to trigger state transitions
    input logic [2:0] y,      // 3-bit input representing the current state
    input logic x,            // 1-bit input used to determine state transitions
    output logic Y0,          // 1-bit output, the least significant bit of the next state
    output logic z            // 1-bit output, determined by the state and input
);

    logic [2:0] next_state;

    // State transition logic
    always @(*) begin
        case (y)
            3'b000: next_state = (x) ? 3'b001 : 3'b000;
            3'b001: next_state = (x) ? 3'b100 : 3'b001;
            3'b010: next_state = (x) ? 3'b001 : 3'b010;
            3'b011: next_state = (x) ? 3'b010 : 3'b001;
            3'b100: next_state = (x) ? 3'b100 : 3'b011;
            default: next_state = 3'b000; // Default behavior for unexpected states
        endcase
    end

    // Output logic
    always @(*) begin
        case (y)
            3'b000, 3'b001, 3'b010: z = 1'b0;
            3'b011, 3'b100: z = 1'b1;
            default: z = 1'b0; // Default behavior for unexpected states
        endcase
    end

    // Update state on clock edge
    always @(posedge clk) begin
        y <= next_state;  // Removing reset functionality as not specified
    end

    // Assign Y0 as the least significant bit of the next state
    assign Y0 = next_state[0];

endmodule
[DONE]
```