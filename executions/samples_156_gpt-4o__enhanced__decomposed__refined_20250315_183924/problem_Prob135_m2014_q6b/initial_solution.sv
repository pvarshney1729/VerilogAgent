[BEGIN]
module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic reset,
    output logic Y1
);

    // State encoding as local parameters
    localparam logic [2:0] A = 3'b000;
    localparam logic [2:0] B = 3'b001;
    localparam logic [2:0] C = 3'b010;
    localparam logic [2:0] D = 3'b011;
    localparam logic [2:0] E = 3'b100;
    localparam logic [2:0] F = 3'b101;

    logic [2:0] current_state, next_state;

    // State transition logic with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A; // Initialize to State A
        end else begin
            current_state <= next_state;
        end
    end

    // Next-state logic
    always @(*) begin
        case (current_state)
            A: next_state = (w == 1'b0) ? B : A;
            B: next_state = (w == 1'b0) ? C : D;
            C: next_state = (w == 1'b0) ? E : D;
            D: next_state = (w == 1'b0) ? F : A;
            E: next_state = (w == 1'b0) ? E : D;
            F: next_state = (w == 1'b0) ? C : D;
            default: next_state = A; // Default to State A
        endcase
    end

    // Output logic
    assign Y1 = current_state[1];

endmodule
[DONE]