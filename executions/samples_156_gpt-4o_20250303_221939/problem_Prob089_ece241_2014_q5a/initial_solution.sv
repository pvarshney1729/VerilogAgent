module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE,
        NEGATE,
        ADD_ONE,
        OUTPUT
    } state_t;

    state_t current_state, next_state;
    logic negate_flag;
    logic add_one_flag;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            z <= 1'b0;
            negate_flag <= 1'b0;
            add_one_flag <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                IDLE: begin
                    z <= 1'b0;
                end
                NEGATE: begin
                    z <= ~x;
                end
                ADD_ONE: begin
                    z <= x ^ add_one_flag;
                    add_one_flag <= add_one_flag & x;
                end
                OUTPUT: begin
                    z <= x;
                end
            endcase
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (x == 1'b1) begin
                    next_state = NEGATE;
                    negate_flag = 1'b1;
                    add_one_flag = 1'b1;
                end
            end
            NEGATE: begin
                if (negate_flag) begin
                    next_state = ADD_ONE;
                end else begin
                    next_state = OUTPUT;
                end
            end
            ADD_ONE: begin
                next_state = OUTPUT;
            end
            OUTPUT: begin
                if (x == 1'b1) begin
                    next_state = NEGATE;
                    negate_flag = 1'b1;
                    add_one_flag = 1'b1;
                end else begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule