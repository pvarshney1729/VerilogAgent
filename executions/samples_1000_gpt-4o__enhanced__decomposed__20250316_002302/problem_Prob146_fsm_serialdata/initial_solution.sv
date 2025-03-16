module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        START = 3'b001,
        DATA  = 3'b010,
        STOP  = 3'b011,
        DONE  = 3'b100
    } state_t;

    // State registers
    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] data_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            data_reg <= 8'b00000000;
            out_byte <= 8'b00000000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA;
                bit_count = 3'b000;
            end
            DATA: begin
                data_reg[bit_count] = in;
                if (bit_count == 3'b111) begin
                    next_state = STOP;
                end else begin
                    bit_count = bit_count + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = DONE;
                end else begin
                    next_state = IDLE; // Error recovery
                end
            end
            DONE: begin
                out_byte = data_reg;
                done = 1'b1;
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE; // Default case for synthesis
            end
        endcase
    end

endmodule