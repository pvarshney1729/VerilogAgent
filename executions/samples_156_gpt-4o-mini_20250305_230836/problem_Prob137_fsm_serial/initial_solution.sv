module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        RECEIVE,
        VERIFY_STOP,
        COMPLETE,
        ERROR
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data;
    logic [3:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            bit_count <= 4'b0;
            data <= 8'b0;
        end else begin
            current_state <= next_state;
            if (current_state == COMPLETE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            bit_count <= 4'b0;
            data <= 8'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    if (in == 1'b0) begin
                        next_state <= RECEIVE;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                RECEIVE: begin
                    if (bit_count < 4'd8) begin
                        data[bit_count] <= in;
                        bit_count <= bit_count + 1;
                        next_state <= RECEIVE;
                    end else begin
                        next_state <= VERIFY_STOP;
                    end
                end
                VERIFY_STOP: begin
                    if (in == 1'b1) begin
                        next_state <= COMPLETE;
                    end else begin
                        next_state <= ERROR;
                    end
                end
                COMPLETE: begin
                    next_state <= IDLE;
                end
                ERROR: begin
                    if (in == 1'b1) begin
                        next_state <= IDLE;
                    end else begin
                        next_state <= ERROR;
                    end
                end
                default: next_state <= IDLE;
            endcase
        end
    end

endmodule