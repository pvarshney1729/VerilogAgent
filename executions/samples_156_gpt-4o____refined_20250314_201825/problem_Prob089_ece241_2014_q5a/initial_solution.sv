[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        INVERT = 2'b01,
        PASS = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic complement;

    // State transition logic
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= IDLE;
            complement <= 1'b0;
        end else begin
            current_state <= next_state;
            if (next_state == INVERT) begin
                complement <= ~x;
            end else if (next_state == PASS) begin
                complement <= x;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                next_state = INVERT;
            end
            INVERT: begin
                if (x == 1'b1) begin
                    next_state = PASS;
                end else begin
                    next_state = INVERT;
                end
            end
            PASS: begin
                next_state = PASS;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    assign z = complement;

endmodule
[END]