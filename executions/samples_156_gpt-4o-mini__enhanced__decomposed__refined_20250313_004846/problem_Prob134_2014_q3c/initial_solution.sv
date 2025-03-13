```
[BEGIN]
module TopModule (
    input logic clk,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);
    logic [2:0] state, next_state;

    // Next state logic
    always @(*) begin
        case (y)
            3'b000: next_state = (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: next_state = (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: next_state = (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: next_state = (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: next_state = (x == 1'b0) ? 3'b011 : 3'b100;
            default: next_state = state; // Hold state on undefined
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        state <= next_state;
    end

    // Output logic
    assign Y0 = next_state[0];

    always @(*) begin
        case (state)
            3'b000, 3'b001, 3'b010: z = 1'b0;
            3'b011, 3'b100: z = 1'b1;
            default: z = 1'b0; // Default output for undefined states
        endcase
    end
endmodule
[DONE]
```