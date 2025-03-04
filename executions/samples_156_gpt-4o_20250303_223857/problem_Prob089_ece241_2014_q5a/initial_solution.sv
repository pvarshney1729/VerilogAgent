module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        INVERT = 2'b01,
        PASSTHROUGH = 2'b10
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                IDLE: z <= 1'b0;
                INVERT: z <= ~x;
                PASSTHROUGH: z <= x;
                default: z <= 1'b0;
            endcase
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (x == 1'b1)
                    next_state = INVERT;
                else
                    next_state = IDLE;
            end
            INVERT: begin
                if (x == 1'b0)
                    next_state = PASSTHROUGH;
                else
                    next_state = INVERT;
            end
            PASSTHROUGH: begin
                next_state = PASSTHROUGH;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule