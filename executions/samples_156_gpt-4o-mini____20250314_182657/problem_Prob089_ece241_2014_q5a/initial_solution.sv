module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE,
        INVERT,
        OUTPUT
    } state_t;

    state_t current_state, next_state;
    logic [1:0] count;
    logic inverted_bit;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            count <= 2'b00;
            inverted_bit <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == INVERT) begin
            inverted_bit <= ~x;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == OUTPUT) begin
            z <= inverted_bit;
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (!areset) begin
                    next_state = INVERT;
                end else begin
                    next_state = IDLE;
                end
            end
            INVERT: begin
                if (count < 2'b11) begin
                    count = count + 1;
                    next_state = INVERT;
                end else begin
                    next_state = OUTPUT;
                end
            end
            OUTPUT: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule