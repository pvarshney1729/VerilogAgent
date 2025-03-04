module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVING,
        VERIFY_STOP,
        COMPLETE
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
                    if (in == 1'b0) begin // Start bit detected
                        next_state <= RECEIVING;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                RECEIVING: begin
                    if (bit_count < 4'd8) begin
                        data[bit_count] <= in; // Capture data bits
                        bit_count <= bit_count + 1;
                        next_state <= RECEIVING;
                    end else begin
                        next_state <= VERIFY_STOP;
                    end
                end
                VERIFY_STOP: begin
                    if (in == 1'b1) begin // Stop bit check
                        next_state <= COMPLETE;
                    end else begin
                        next_state <= IDLE; // Invalid stop bit, go back to IDLE
                    end
                end
                COMPLETE: begin
                    next_state <= IDLE; // Return to IDLE after done
                end
                default: begin
                    next_state <= IDLE; // Default to IDLE for safety
                end
            endcase
        end
    end

endmodule