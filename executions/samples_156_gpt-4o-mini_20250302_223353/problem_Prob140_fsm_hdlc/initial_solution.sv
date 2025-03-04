module TopModule (
    input logic clk,          // Clock signal, positive edge triggered
    input logic reset,        // Active high synchronous reset
    input logic in,           // Input bit stream
    output logic disc,        // Output signal to discard a bit
    output logic flag,        // Output signal to indicate a flag (frame boundary)
    output logic err          // Output signal to indicate an error (7 or more consecutive 1s)
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        ONE_1 = 3'b001,
        TWO_1 = 3'b010,
        THREE_1 = 3'b011,
        FOUR_1 = 3'b100,
        FIVE_1 = 3'b101,
        SIX_1 = 3'b110,
        SEVEN_1 = 3'b111
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    if (in) begin
                        next_state <= ONE_1;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                ONE_1: begin
                    if (in) begin
                        next_state <= TWO_1;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                TWO_1: begin
                    if (in) begin
                        next_state <= THREE_1;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                THREE_1: begin
                    if (in) begin
                        next_state <= FOUR_1;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                FOUR_1: begin
                    if (in) begin
                        next_state <= FIVE_1;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                FIVE_1: begin
                    if (in) begin
                        next_state <= SIX_1;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                SIX_1: begin
                    if (in) begin
                        next_state <= SEVEN_1;
                        flag <= 1'b1;
                        err <= 1'b0;
                    end else begin
                        next_state <= IDLE;
                        disc <= 1'b1;
                    end
                end
                SEVEN_1: begin
                    if (in) begin
                        err <= 1'b1;
                    end else begin
                        next_state <= IDLE;
                        disc <= 1'b1;
                    end
                end
                default: next_state <= IDLE;
            endcase
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == SIX_1) begin
            disc <= 1'b0; // Clear disc after one cycle
        end
        if (current_state == SEVEN_1) begin
            err <= 1'b0; // Clear err after one cycle
        end
        if (current_state == IDLE && in) begin
            flag <= 1'b0; // Clear flag after one cycle
        end
    end

endmodule