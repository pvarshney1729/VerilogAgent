module TopModule (
    input logic [5:0] y,
    input logic w,
    input logic clk,
    input logic reset,
    output logic Y1,
    output logic Y3,
    output logic Y2,
    output logic Y4
);

    // State encoding
    localparam logic [5:0] STATE_A = 6'b000001;
    localparam logic [5:0] STATE_B = 6'b000010;
    localparam logic [5:0] STATE_C = 6'b000100;
    localparam logic [5:0] STATE_D = 6'b001000;
    localparam logic [5:0] STATE_E = 6'b010000;
    localparam logic [5:0] STATE_F = 6'b100000;

    logic [5:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (w == 1'b0) ? STATE_B : STATE_A;
            STATE_B: next_state = (w == 1'b0) ? STATE_C : STATE_D;
            STATE_C: next_state = (w == 1'b0) ? STATE_E : STATE_D;
            STATE_D: next_state = (w == 1'b0) ? STATE_F : STATE_A;
            STATE_E: next_state = (w == 1'b0) ? STATE_E : STATE_D;
            STATE_F: next_state = (w == 1'b0) ? STATE_C : STATE_D;
            default: next_state = STATE_A; // Default to state A on invalid state
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        Y1 = (state == STATE_E) || (state == STATE_F);
        Y2 = y[1];
        Y3 = 1'b0; // Placeholder for unspecified functionality
        Y4 = y[3];
    end

endmodule