module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVING,
        STOPCHECK,
        ERRORRECOVERY
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] data_buffer;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            bit_count <= 3'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVING) begin
                data_buffer[bit_count] <= in;
                bit_count <= bit_count + 1;
            end
            if (current_state == STOPCHECK && next_state == IDLE) begin
                out_byte <= data_buffer;
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
                    next_state = RECEIVING;
                    bit_count = 3'b0;
                end
            end
            RECEIVING: begin
                if (bit_count == 3'b111) begin
                    next_state = STOPCHECK;
                end
            end
            STOPCHECK: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERRORRECOVERY;
                end
            end
            ERRORRECOVERY: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule