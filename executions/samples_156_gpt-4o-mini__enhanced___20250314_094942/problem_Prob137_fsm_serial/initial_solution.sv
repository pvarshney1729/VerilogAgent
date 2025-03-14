module TopModule (
    input logic clk,          // Clock signal, positive edge triggered
    input logic reset,        // Active-high synchronous reset
    input logic in,          // Serial input data bit
    output logic done         // Output signal indicating byte reception completion
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVING,
        VERIFY_STOP
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data;
    logic [2:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
            bit_count <= 0;
            data <= 8'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVING) begin
                data[bit_count] <= in;
                bit_count <= bit_count + 1;
            end
            if (current_state == VERIFY_STOP && in == 1'b1) begin
                done <= 1;
            end else if (current_state == VERIFY_STOP) begin
                done <= 0;
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = RECEIVING;
                    bit_count = 0;
                end else begin
                    next_state = IDLE;
                end
            end
            RECEIVING: begin
                if (bit_count == 3'b111) begin
                    next_state = VERIFY_STOP;
                end else begin
                    next_state = RECEIVING;
                end
            end
            VERIFY_STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = VERIFY_STOP;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule