module TopModule (
    input wire clk,         // Clock input
    input wire aresetn,     // Asynchronous active-low reset
    input wire x,           // Input signal for sequence detection
    output reg z            // Output signal, asserted for sequence "101"
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        S1   = 2'b01,
        S10  = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        z = 1'b0;

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
                    z = 1'b1;
                end else begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule