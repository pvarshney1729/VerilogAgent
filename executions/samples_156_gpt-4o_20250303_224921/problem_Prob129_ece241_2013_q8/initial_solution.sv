module TopModule (
    input logic clk,
    input logic aresetn,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        S1   = 2'b01,
        S10  = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default state remains the same
        z = 1'b0; // Default output

        case (current_state)
            IDLE: begin
                if (x)
                    next_state = S1;
            end
            S1: begin
                if (!x)
                    next_state = S10;
            end
            S10: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Assert z when "101" is detected
                end else
                    next_state = IDLE;
            end
        endcase
    end

endmodule