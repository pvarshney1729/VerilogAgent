module serial_receiver (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVING,
        STOP_BIT_CHECK,
        OUTPUT
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b00000000;
            done <= 1'b0;
            bit_count <= 4'b0000;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == RECEIVING) begin
            out_byte[bit_count] <= in;
            bit_count <= bit_count + 1;
        end
    end

    always_comb begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = RECEIVING;
                    bit_count = 4'b0000;
                end
            end
            RECEIVING: begin
                if (bit_count == 4'b0111) begin // 8 bits received
                    next_state = STOP_BIT_CHECK;
                end
            end
            STOP_BIT_CHECK: begin
                if (in == 1'b1) begin // Stop bit detected
                    next_state = OUTPUT;
                end else begin
                    next_state = IDLE; // Error, return to idle
                end
            end
            OUTPUT: begin
                done = 1'b1; // Assert done for one cycle
                next_state = IDLE; // Return to idle after output
            end
        endcase
    end

endmodule