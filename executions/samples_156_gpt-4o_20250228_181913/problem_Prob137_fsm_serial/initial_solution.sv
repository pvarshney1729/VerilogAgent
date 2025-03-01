module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        RECEIVE = 2'b01,
        VERIFY_STOP = 2'b10
    } state_t;

    state_t state, next_state;
    logic [7:0] data_shift;
    logic [3:0] bit_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            data_shift <= 8'b0;
            bit_count <= 4'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == RECEIVE) begin
                data_shift <= {in, data_shift[7:1]};
                bit_count <= bit_count + 1;
            end
            if (state == VERIFY_STOP && in == 1'b1) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = RECEIVE;
                end
            end
            RECEIVE: begin
                if (bit_count == 4'd8) begin
                    next_state = VERIFY_STOP;
                end
            end
            VERIFY_STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule