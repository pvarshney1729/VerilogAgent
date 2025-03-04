```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State encoding
    localparam logic STATE_A = 1'b0;
    localparam logic STATE_B = 1'b1;

    // State register
    logic current_state, next_state;

    // Asynchronous reset logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_B;
        else
            current_state <= next_state;
    end

    // Next state logic and output logic
    always_comb begin
        case (current_state)
            STATE_A: begin
                out = 1'b0;
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end

            STATE_B: begin
                out = 1'b1;
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end

            default: begin
                next_state = STATE_B; // Default state to handle unexpected cases
                out = 1'b1;
            end
        endcase
    end

endmodule
```