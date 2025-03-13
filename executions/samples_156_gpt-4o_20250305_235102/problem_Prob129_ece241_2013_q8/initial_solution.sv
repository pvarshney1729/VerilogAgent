module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        STATE1 = 2'b01,
        STATE2 = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= IDLE;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        z = 1'b0; // Default output

        case (current_state)
            IDLE: begin
                if (x) next_state = STATE1;
            end
            STATE1: begin
                if (!x) next_state = STATE2;
            end
            STATE2: begin
                if (x) begin
                    next_state = STATE1;
                    z = 1'b1; // Sequence "101" detected
                end else begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule