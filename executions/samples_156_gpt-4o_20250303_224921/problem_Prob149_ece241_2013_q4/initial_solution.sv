```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [2:0] s,
    output logic fr2,
    output logic fr1,
    output logic fr0,
    output logic dfr
);

    typedef enum logic [1:0] {
        STATE_ABOVE_S2 = 2'b00,
        STATE_BETWEEN_S2_S1 = 2'b01,
        STATE_BETWEEN_S1_S0 = 2'b10,
        STATE_BELOW_S0 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_BELOW_S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (s)
            3'b111: next_state = STATE_ABOVE_S2;
            3'b011: next_state = STATE_BETWEEN_S2_S1;
            3'b001: next_state = STATE_BETWEEN_S1_S0;
            default: next_state = STATE_BELOW_S0;
        endcase
    end

    // Output logic
    always_comb begin
        // Default all outputs to deasserted
        fr2 = 1'b0;
        fr1 = 1'b0;
        fr0 = 1'b0;
        dfr = 1'b0;

        case (current_state)
            STATE_ABOVE_S2: begin
                // All outputs remain deasserted
            end
            STATE_BETWEEN_S2_S1: begin
                fr0 = 1'b1;
            end
            STATE_BETWEEN_S1_S0: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
            end
            STATE_BELOW_S0: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
                fr2 = 1'b1;
                dfr = 1'b1;
            end
        endcase
    end

endmodule
```