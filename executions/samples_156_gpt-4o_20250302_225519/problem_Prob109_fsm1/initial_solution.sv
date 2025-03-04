module TopModule (
    input logic clk,        // Clock input
    input logic areset,     // Asynchronous reset input, active high
    input logic in,         // Data input
    output logic out        // Output, reflects the Moore machine output
);

    // State encoding
    typedef enum logic {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t state; // Current state

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end else begin
            case (state)
                STATE_A: begin
                    if (in == 0) state <= STATE_B;
                end
                STATE_B: begin
                    if (in == 0) state <= STATE_A;
                end
            endcase
        end
    end

    always_comb begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
        endcase
    end

endmodule