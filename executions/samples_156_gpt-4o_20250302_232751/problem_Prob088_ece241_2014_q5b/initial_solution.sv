module TopModule (
    input  logic clk,         // Clock signal, triggering on positive edge
    input  logic areset,      // Asynchronous active-high reset
    input  logic x,           // Input signal to be complemented
    output logic z            // Output signal representing 2's complement
);

    typedef enum logic [1:0] {
        STATE_A = 2'b01,
        STATE_B = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (x == 1'b1) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B: begin
                if (x == 1'b1) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_B;
                end
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_A: z = 1'b0;
            STATE_B: z = (x == 1'b1) ? 1'b0 : 1'b1;
            default: z = 1'b0;
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

endmodule