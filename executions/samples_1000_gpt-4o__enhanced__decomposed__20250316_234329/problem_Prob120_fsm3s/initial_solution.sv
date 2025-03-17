module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    // State encoding
    localparam logic [1:0] STATE_A = 2'b00;
    localparam logic [1:0] STATE_B = 2'b01;
    localparam logic [1:0] STATE_C = 2'b10;
    localparam logic [1:0] STATE_D = 2'b11;

    // State register
    logic [1:0] current_state, next_state;

    // State register with synchronous active high reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A; // Reset to state A
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                if (in == 1'b0)
                    next_state = STATE_C;
                else
                    next_state = STATE_B;
            end
            STATE_C: begin
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_D;
            end
            STATE_D: begin
                if (in == 1'b0)
                    next_state = STATE_C;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_A; // Default to state A for safety
        endcase
    end

    // Output logic
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