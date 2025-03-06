module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= STATE_0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold state
        z = 1'b0; // Default output

        case (current_state)
            STATE_0: begin
                if (x) begin
                    next_state = STATE_1;
                end
            end

            STATE_1: begin
                if (!x) begin
                    next_state = STATE_2;
                end
            end

            STATE_2: begin
                if (x) begin
                    next_state = STATE_1;
                    z = 1'b1; // Sequence "101" detected
                end else begin
                    next_state = STATE_0;
                end
            end

            default: begin
                next_state = STATE_0;
            end
        endcase
    end

endmodule