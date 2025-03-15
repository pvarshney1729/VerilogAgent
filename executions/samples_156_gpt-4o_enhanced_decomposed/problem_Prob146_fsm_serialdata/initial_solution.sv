module TopModule(
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        RECEIVE = 2'b01,
        STOP    = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] data_byte;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            data_byte <= 8'b00000000;
            out_byte <= 8'b00000000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                data_byte <= {in, data_byte[7:1]};
                bit_count <= bit_count + 1;
            end
            if (current_state == DONE) begin
                out_byte <= data_byte;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = RECEIVE;
                end else begin
                    next_state = IDLE;
                end
            end
            RECEIVE: begin
                if (bit_count == 3'b111) begin
                    next_state = STOP;
                end else begin
                    next_state = RECEIVE;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = DONE;
                end else begin
                    next_state = IDLE;
                end
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule