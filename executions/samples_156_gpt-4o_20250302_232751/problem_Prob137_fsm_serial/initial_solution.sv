module serial_receiver (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        RECEIVE = 3'b010,
        STOP = 3'b011,
        DONE = 3'b100,
        ERROR = 3'b101
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data;
    logic [2:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            data <= 8'b0;
            bit_count <= 3'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DONE) begin
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
                if (in == 1'b0) begin
                    next_state = RECEIVE;
                    bit_count = 3'b0;
                end else begin
                    next_state = ERROR;
                end
            end
            RECEIVE: begin
                if (bit_count < 3'd7) begin
                    data[bit_count] = in;
                    bit_count = bit_count + 1;
                end else begin
                    data[bit_count] = in;
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = DONE;
                end else begin
                    next_state = ERROR;
                end
            end
            DONE: begin
                next_state = IDLE;
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