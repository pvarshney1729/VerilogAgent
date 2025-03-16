[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic x,
    input  logic [2:0] y,
    output logic Y0,
    output logic z
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
            default: next_state = 3'b000;
        endcase
    end

    // Output logic
    assign z = (y == 3'b011) ? 1'b1 : 1'b0;

    // State register with synchronous reset
    always @(posedge clk) begin
        Y0 <= next_state[0];
    end

endmodule
```
[DONE]