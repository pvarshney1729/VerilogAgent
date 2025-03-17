module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic out
);

    // State encoding
    localparam logic [1:0] STATE_A = 2'b00;
    localparam logic [1:0] STATE_B = 2'b01;
    localparam logic [1:0] STATE_C = 2'b10;
    localparam logic [1:0] STATE_D = 2'b11;

    // State register
    logic [1:0] state, next_state;

    // State register with synchronous active high reset
    always @(posedge clk) begin
        if (reset)
            state <= STATE_A;  // Reset to state A
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (in == 1'b0) ? STATE_A : STATE_B;
            STATE_B: next_state = (in == 1'b0) ? STATE_C : STATE_B;
            STATE_C: next_state = (in == 1'b0) ? STATE_A : STATE_D;
            STATE_D: next_state = (in == 1'b0) ? STATE_C : STATE_B;
            default: next_state = STATE_A; // Default to state A
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b0;
            STATE_C: out = 1'b0;
            STATE_D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule