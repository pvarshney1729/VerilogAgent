module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        START = 3'b001,
        DATA  = 3'b010,
        STOP  = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [7:0] shift_reg;
    logic [2:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_reg <= 8'b0;
            bit_count <= 3'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 1;
            end
            if (current_state == STOP && in == 1'b1) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'b111) begin
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule