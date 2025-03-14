[BEGIN]
module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic rst_n,
    output logic Y1
);

    logic [2:0] state, next_state;

    // State Encoding
    localparam logic [2:0] A = 3'b000,
                           B = 3'b001,
                           C = 3'b010,
                           D = 3'b011,
                           E = 3'b100,
                           F = 3'b101;

    // Next-state logic
    always @(*) begin
        case (state)
            A: next_state = (w == 1'b0) ? B : A;
            B: next_state = (w == 1'b0) ? C : D;
            C: next_state = (w == 1'b0) ? E : D;
            D: next_state = (w == 1'b0) ? F : A;
            E: next_state = (w == 1'b0) ? E : D;
            F: next_state = (w == 1'b0) ? C : D;
            default: next_state = A; // handle undefined states
        endcase
    end

    // State transition
    always @(posedge clk) begin
        if (!rst_n)
            state <= A; // synchronous reset to state A
        else
            state <= next_state;
    end

    // Output logic
    assign Y1 = state[1];

endmodule
[DONE]