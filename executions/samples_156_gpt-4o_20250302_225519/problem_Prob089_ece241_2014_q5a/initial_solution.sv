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
    logic complement_bit;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            z <= complement_bit;
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (x == 1'b1) begin
                    next_state = INVERT;
                    complement_bit = 1'b1;
                end else begin
                    next_state = PASS;
                    complement_bit = 1'b0;
                end
            end
            INVERT: begin
                next_state = INVERT;
                complement_bit = ~x;
            end
            PASS: begin
                next_state = PASS;
                complement_bit = x;
            end
            default: begin
                next_state = IDLE;
                complement_bit = 1'b0;
            end
        endcase
    end

endmodule