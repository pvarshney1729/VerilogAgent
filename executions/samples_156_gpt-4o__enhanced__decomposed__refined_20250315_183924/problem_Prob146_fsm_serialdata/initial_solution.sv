[BEGIN]
module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE         = 3'b000,
        START_BIT    = 3'b001,
        DATA_BITS    = 3'b010,
        STOP_BIT     = 3'b011,
        DONE_STATE   = 3'b100
    } state_t;

    state_t state, next_state;
    logic [2:0] bit_counter;
    logic [7:0] shift_register;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'b00000000;
            done <= 1'b0;
            bit_counter <= 3'b000;
            shift_register <= 8'b00000000;
        end else begin
            state <= next_state;
            case (state)
                DATA_BITS: begin
                    shift_register <= {in, shift_register[7:1]};
                    bit_counter <= bit_counter + 1;
                end
                DONE_STATE: begin
                    out_byte <= shift_register;
                    done <= 1'b1;
                end
                default: begin
                    done <= 1'b0;
                end
            endcase
        end
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default to no state change
        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BITS;
                bit_counter = 3'b000;
            end
            DATA_BITS: begin
                if (bit_counter == 3'd7)
                    next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) // Valid stop bit
                    next_state = DONE_STATE;
                else
                    next_state = IDLE; // Invalid stop bit, go back to idle
            end
            DONE_STATE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
[DONE]