```verilog
[BEGIN]
module TopModule (
    input logic clk,       // Clock input, positive-edge triggered
    input logic reset,     // Reset input, active-high, synchronous
    input logic w,         // Input signal, 1-bit
    output logic z         // Output signal, 1-bit
);

    // State encoding
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    localparam E = 3'b100;
    localparam F = 3'b101;

    logic [2:0] state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (w == 1'b0) ? B : A;
            B: next_state = (w == 1'b0) ? C : D;
            C: next_state = (w == 1'b0) ? E : D;
            D: next_state = (w == 1'b0) ? F : A;
            E: next_state = (w == 1'b0) ? E : D;
            F: next_state = (w == 1'b0) ? C : D;
            default: next_state = A;  // Default case to handle unforeseen states
        endcase
    end

    // Output logic
    always @(*) begin
        z = (state == E || state == F) ? 1'b1 : 1'b0;
    end

endmodule
[DONE]
```