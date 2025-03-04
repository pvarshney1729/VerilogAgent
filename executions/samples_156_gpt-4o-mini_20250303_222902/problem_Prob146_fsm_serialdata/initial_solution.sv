module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        START,
        RECEIVE,
        STOP,
        ERROR
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data_buffer;
    logic [2:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            bit_count <= 3'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                data_buffer[bit_count] <= in;
                bit_count <= bit_count + 1;
            end
            if (current_state == STOP) begin
                if (in == 1'b1) begin
                    out_byte <= data_buffer;
                    done <= 1'b1;
                end else begin
                    next_state <= ERROR;
                end
            end
            if (current_state == IDLE) begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) next_state = START;
                else next_state = IDLE;
            end
            START: begin
                next_state = RECEIVE;
            end
            RECEIVE: begin
                if (bit_count == 3'b111) next_state = STOP;
                else next_state = RECEIVE;
            end
            STOP: begin
                if (in == 1'b1) next_state = IDLE;
                else next_state = ERROR;
            end
            ERROR: begin
                if (in == 1'b1) next_state = IDLE;
                else next_state = ERROR;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule