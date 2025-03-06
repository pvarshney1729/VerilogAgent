```verilog
module TopModule(
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic rst,
    output logic Y1
);

    logic [2:0] state, next_state;

    // State encoding
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    localparam E = 3'b100;
    localparam F = 3'b101;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (w == 1'b0) ? B : A;
            B: next_state = (w == 1'b0) ? C : D;
            C: next_state = (w == 1'b0) ? E : D;
            D: next_state = (w == 1'b0) ? F : A;
            E: next_state = (w == 1'b0) ? E : D;
            F: next_state = (w == 1'b0) ? C : D;
            default: next_state = A; // Reset to A on invalid state
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (rst) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign Y1 = y[1];

endmodule
```