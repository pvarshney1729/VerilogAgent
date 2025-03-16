[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE; // IDLE state
            bit_count <= 4'b0000;
            done <= 1'b0; // Reset done signal
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_count <= bit_count + 4'b0001;
            end else if (current_state == IDLE) begin
                bit_count <= 4'b0000;
            end
        end
    end

    always_ff @(posedge clk) begin
        done <= 1'b0; // Default done to 0
    end

    always_comb begin
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA; // Move to DATA state after detecting start bit
            end
            DATA: begin
                if (bit_count == 4'b0111) begin // 8 bits received
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done <= 1'b1; // Byte received successfully
                    next_state = IDLE; // Go back to IDLE
                end
            end
            default: begin
                next_state = IDLE; // Default state
            end
        endcase
    end

endmodule
[DONE]