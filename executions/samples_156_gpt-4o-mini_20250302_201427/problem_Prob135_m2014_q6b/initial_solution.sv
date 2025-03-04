module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic rst_n,
    output logic Y1
);

    logic [2:0] state, next_state;

    // State encoding
    localparam STATE_A = 3'b000;
    localparam STATE_B = 3'b001;
    localparam STATE_C = 3'b010;
    localparam STATE_D = 3'b011;
    localparam STATE_E = 3'b100;
    localparam STATE_F = 3'b101;

    // Synchronous state transition
    always @(posedge clk) begin
        if (!rst_n) begin
            state <= STATE_A; // Reset to State A
        end else begin
            state <= next_state; // Update state
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (w == 1'b0) ? STATE_B : STATE_A;
            STATE_B: next_state = (w == 1'b0) ? STATE_C : STATE_D;
            STATE_C: next_state = (w == 1'b0) ? STATE_E : STATE_D;
            STATE_D: next_state = (w == 1'b0) ? STATE_F : STATE_A;
            STATE_E: next_state = (w == 1'b0) ? STATE_E : STATE_D;
            STATE_F: next_state = (w == 1'b0) ? STATE_C : STATE_D;
            default: next_state = STATE_A; // Undefined state handling
        endcase
    end

    // Output logic
    assign Y1 = state[1]; // Output Y1 reflects y[1]

endmodule