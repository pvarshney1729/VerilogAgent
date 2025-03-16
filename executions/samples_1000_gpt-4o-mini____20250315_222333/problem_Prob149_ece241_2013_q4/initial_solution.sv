module TopModule (
    input logic clk,
    input logic reset,
    input logic [2:0] s,
    output logic fr2,
    output logic fr1,
    output logic fr0,
    output logic dfr
);

    logic [1:0] state, next_state;

    // State encoding
    localparam STATE_LOW = 2'b00;    // Below s[0]
    localparam STATE_BETWEEN1 = 2'b01; // Between s[1] and s[0]
    localparam STATE_BETWEEN2 = 2'b10; // Between s[2] and s[1]
    localparam STATE_HIGH = 2'b11;    // Above s[2]

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_LOW;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_LOW: begin
                if (s[0]) begin
                    next_state = STATE_BETWEEN1;
                end else begin
                    next_state = STATE_LOW;
                end
            end
            STATE_BETWEEN1: begin
                if (s[1]) begin
                    next_state = STATE_BETWEEN2;
                end else if (s[0]) begin
                    next_state = STATE_LOW;
                end else begin
                    next_state = STATE_BETWEEN1;
                end
            end
            STATE_BETWEEN2: begin
                if (s[2]) begin
                    next_state = STATE_HIGH;
                end else if (s[1]) begin
                    next_state = STATE_BETWEEN1;
                end else begin
                    next_state = STATE_BETWEEN2;
                end
            end
            STATE_HIGH: begin
                next_state = STATE_HIGH; // Remain in high state
            end
            default: next_state = STATE_LOW; // Default case
        endcase
    end

    // Output logic based on state
    always @(*) begin
        fr2 = 1'b0;
        fr1 = 1'b0;
        fr0 = 1'b0;
        dfr = 1'b0;

        case (state)
            STATE_LOW: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                fr0 = 1'b1;
                dfr = 1'b1;
            end
            STATE_BETWEEN1: begin
                fr1 = 1'b1;
                fr0 = 1'b1;
                dfr = 1'b0;
            end
            STATE_BETWEEN2: begin
                fr0 = 1'b1;
                dfr = 1'b0;
            end
            STATE_HIGH: begin
                fr2 = 1'b0;
                fr1 = 1'b0;
                fr0 = 1'b0;
                dfr = 1'b0;
            end
        endcase
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly