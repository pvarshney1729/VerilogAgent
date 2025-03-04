module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        INIT = 2'b00,
        COMPLEMENT = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic complement_bit;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= INIT;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            z <= complement_bit;
        end
    end

    always_comb begin
        next_state = current_state;
        complement_bit = z;

        case (current_state)
            INIT: begin
                if (!areset) begin
                    next_state = COMPLEMENT;
                end
            end
            COMPLEMENT: begin
                complement_bit = ~x;
            end
        endcase
    end

endmodule