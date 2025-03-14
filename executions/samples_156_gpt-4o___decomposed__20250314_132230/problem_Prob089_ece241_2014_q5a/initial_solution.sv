module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    // State Encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        INVERT = 2'b01,
        PASS = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic and output logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (x)
                    next_state = INVERT;
                else
                    next_state = PASS;
                z = 0;
            end
            INVERT: begin
                next_state = PASS;
                z = ~x;
            end
            PASS: begin
                next_state = PASS;
                z = x;
            end
            default: begin
                next_state = IDLE;
                z = 0;
            end
        endcase
    end

endmodule