```verilog
[BEGIN]
module TopModule(
    input logic clk,            // Clock input
    input logic resetn,        // Active-low synchronous reset
    input logic [2:0] r,       // Request inputs from devices [2:0]
    output logic [2:0] g       // Grant outputs to devices [2:0]
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t state, next_state;

    // State register update with synchronous reset
    always_ff @(posedge clk) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            STATE_A: begin
                if (r[0] == 1'b1)
                    next_state = STATE_B;
                else if (r[1] == 1'b1)
                    next_state = STATE_C;
                else if (r[2] == 1'b1)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (r[0] == 1'b1)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_C: begin
                if (r[1] == 1'b1)
                    next_state = STATE_C;
                else
                    next_state = STATE_A;
            end
            STATE_D: begin
                if (r[2] == 1'b1)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always_comb begin
        g = 3'b000;
        case (state)
            STATE_B: g[0] = 1'b1;
            STATE_C: g[1] = 1'b1;
            STATE_D: g[2] = 1'b1;
        endcase
    end

endmodule
[DONE]
```