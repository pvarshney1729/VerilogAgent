module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVE,
        VERIFY,
        ERROR
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data;
    logic [2:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            data <= 8'b0;
            bit_count <= 3'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                data[bit_count] <= in;
                bit_count <= bit_count + 1'b1;
            end else if (current_state == VERIFY) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = RECEIVE;
                    bit_count = 3'b0;
                end else begin
                    next_state = IDLE;
                end
            end
            RECEIVE: begin
                if (bit_count == 3'b111) begin
                    next_state = VERIFY;
                end else begin
                    next_state = RECEIVE;
                end
            end
            VERIFY: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule