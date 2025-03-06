module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVE_DATA,
        CHECK_STOP
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] data_buffer;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'bxxxxxxxx;
            done <= 0;
            bit_count <= 3'b000;
            data_buffer <= 8'b00000000;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == RECEIVE_DATA) begin
            data_buffer[bit_count] <= in;
            bit_count <= bit_count + 1;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == CHECK_STOP) begin
            if (in) begin
                out_byte <= data_buffer;
                done <= 1;
            end else begin
                done <= 0;
            end
        end else begin
            done <= 0;
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (!in) begin
                    next_state = RECEIVE_DATA;
                    bit_count = 3'b000;
                end else begin
                    next_state = IDLE;
                end
            end
            RECEIVE_DATA: begin
                if (bit_count == 3'b111) begin
                    next_state = CHECK_STOP;
                end else begin
                    next_state = RECEIVE_DATA;
                end
            end
            CHECK_STOP: begin
                if (in) begin
                    next_state = IDLE;
                end else begin
                    next_state = CHECK_STOP;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule