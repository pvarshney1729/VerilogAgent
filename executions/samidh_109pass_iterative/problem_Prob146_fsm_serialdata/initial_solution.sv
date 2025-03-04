module TopModule(
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START_BIT_DETECTED = 3'b001,
        DATA_RECEPTION = 3'b010,
        STOP_BIT_CHECK = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] shift_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            bit_count <= 3'b0;
            shift_reg <= 8'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                IDLE: begin
                    if (in == 1'b0) begin
                        next_state <= START_BIT_DETECTED;
                    end
                end
                START_BIT_DETECTED: begin
                    next_state <= DATA_RECEPTION;
                end
                DATA_RECEPTION: begin
                    shift_reg <= {in, shift_reg[7:1]};
                    bit_count <= bit_count + 1;
                    if (bit_count == 3'b111) begin
                        next_state <= STOP_BIT_CHECK;
                    end
                end
                STOP_BIT_CHECK: begin
                    if (in == 1'b1) begin
                        out_byte <= shift_reg;
                        done <= 1'b1;
                        next_state <= DONE;
                    end else if (in == 1'b0) begin
                        next_state <= START_BIT_DETECTED;
                    end
                end
                DONE: begin
                    done <= 1'b0;
                    next_state <= IDLE;
                end
            endcase
        end
    end

    always_comb begin
        case (current_state)
            IDLE: next_state = (in == 1'b0) ? START_BIT_DETECTED : IDLE;
            START_BIT_DETECTED: next_state = DATA_RECEPTION;
            DATA_RECEPTION: next_state = (bit_count == 3'b111) ? STOP_BIT_CHECK : DATA_RECEPTION;
            STOP_BIT_CHECK: next_state = (in == 1'b1) ? DONE : (in == 1'b0) ? START_BIT_DETECTED : STOP_BIT_CHECK;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

endmodule