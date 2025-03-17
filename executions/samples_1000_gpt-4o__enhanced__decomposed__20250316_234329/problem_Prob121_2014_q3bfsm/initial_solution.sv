module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    // State encoding
    localparam logic [2:0] STATE_000 = 3'b000;
    localparam logic [2:0] STATE_001 = 3'b001;
    localparam logic [2:0] STATE_010 = 3'b010;
    localparam logic [2:0] STATE_011 = 3'b011;
    localparam logic [2:0] STATE_100 = 3'b100;

    // State registers
    logic [2:0] state, next_state;

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset)
            state <= STATE_000; // Reset state to 000
        else
            state <= next_state; // Update state
    end

    // Next state logic
    always_comb begin
        case (state)
            STATE_000: next_state = (x == 1'b0) ? STATE_000 : STATE_001;
            STATE_001: next_state = (x == 1'b0) ? STATE_001 : STATE_100;
            STATE_010: next_state = (x == 1'b0) ? STATE_010 : STATE_001;
            STATE_011: next_state = (x == 1'b0) ? STATE_001 : STATE_010;
            STATE_100: next_state = (x == 1'b0) ? STATE_011 : STATE_100;
            default: next_state = STATE_000; // Default case for safety
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            STATE_000: z = 1'b0;
            STATE_001: z = 1'b0;
            STATE_010: z = 1'b0;
            STATE_011: z = 1'b1;
            STATE_100: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule