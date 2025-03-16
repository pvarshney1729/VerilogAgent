```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);
    logic [2:0] state, next_state;

    // Synchronous reset and state update
    always @(posedge clk) begin
        state <= next_state;
    end

    // Combinational logic for next state and output
    always @(*) begin
        z = 1'b0; // Default output for z
        next_state = state; // Default to current state
        case (state)
            3'b000: next_state = (x) ? 3'b001 : 3'b000;
            3'b001: next_state = (x) ? 3'b100 : 3'b001;
            3'b010: next_state = (x) ? 3'b001 : 3'b010;
            3'b011: begin
                next_state = (x) ? 3'b010 : 3'b001;
                z = 1'b1;
            end
            3'b100: begin
                next_state = (x) ? 3'b100 : 3'b011;
                z = 1'b1;
            end
            default: next_state = 3'b000;
        endcase
    end

    // Output logic
    assign Y0 = next_state[0];

endmodule
[DONE]
```