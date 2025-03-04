module TopModule(
    input  logic clk,         // Clock signal, positive edge-triggered
    input  logic reset,       // Active-high synchronous reset
    input  logic in,          // Serial input data stream
    output logic done         // Output high if a byte is correctly received
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA_RECEIVE = 3'b010,
        STOP_VERIFY = 3'b011,
        COMPLETE = 3'b100
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
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_RECEIVE) begin
                data_byte <= {in, data_byte[7:1]};
                bit_count <= bit_count + 1;
            end
            if (current_state == COMPLETE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA_RECEIVE;
            end
            DATA_RECEIVE: begin
                if (bit_count == 3'b111) begin
                    next_state = STOP_VERIFY;
                end
            end
            STOP_VERIFY: begin
                if (in == 1'b1) begin
                    next_state = COMPLETE;
                end else begin
                    next_state = IDLE;
                end
            end
            COMPLETE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule