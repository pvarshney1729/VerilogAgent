[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            3'b000: next_state = (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: next_state = (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: next_state = (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: next_state = (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: next_state = (x == 1'b0) ? 3'b011 : 3'b100;
            default: next_state = 3'b000;
        endcase
    end

    // Output logic
    assign z = (state == 3'b011) || (state == 3'b100);
    assign Y0 = next_state[0];

    // State register with synchronous reset
    always @(posedge clk) begin
        state <= next_state; // Update state on clock edge
    end

    // Initialize state to zero using a synchronous reset
    always @(posedge clk) begin
        if (state == 3'b000) begin
            state <= 3'b000;  // Maintain state on reset
        end
    end

endmodule
```
[DONE]