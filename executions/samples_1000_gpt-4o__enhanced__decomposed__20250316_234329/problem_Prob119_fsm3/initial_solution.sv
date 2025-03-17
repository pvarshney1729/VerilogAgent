module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State encoding using localparam
    localparam logic [1:0] STATE_A = 2'b00;
    localparam logic [1:0] STATE_B = 2'b01;
    localparam logic [1:0] STATE_C = 2'b10;
    localparam logic [1:0] STATE_D = 2'b11;

    // State register
    logic [1:0] current_state, next_state;

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (in == 1'b0) ? STATE_A : STATE_B;
            STATE_B: next_state = (in == 1'b0) ? STATE_C : STATE_B;
            STATE_C: next_state = (in == 1'b0) ? STATE_A : STATE_D;
            STATE_D: next_state = (in == 1'b0) ? STATE_C : STATE_B;
            default: next_state = STATE_A; // Default case for safety
        endcase
    end

    // Combinational logic for output
    always @(*) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b0;
            STATE_C: out = 1'b0;
            STATE_D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule