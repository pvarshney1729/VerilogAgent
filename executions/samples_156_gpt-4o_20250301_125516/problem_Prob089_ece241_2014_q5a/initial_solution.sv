module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE,
        PROCESS,
        COMPLEMENT
    } state_t;

    state_t current_state, next_state;
    logic carry;
    logic x_reg;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            z <= 1'b0;
            carry <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == PROCESS) begin
                {carry, z} <= x_reg + carry;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (!areset) next_state = PROCESS;
            end
            PROCESS: begin
                next_state = COMPLEMENT;
            end
            COMPLEMENT: begin
                if (areset) next_state = IDLE;
            end
        endcase
    end

    // Input register
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            x_reg <= 1'b0;
        end else begin
            x_reg <= x;
        end
    end

endmodule