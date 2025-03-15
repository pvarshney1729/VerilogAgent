module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            bit_count <= 4'b0000;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = START;
                end
            end
            START: begin
                bit_count <= 4'b0000; // Reset bit count
                next_state = DATA; // Move to data state after start bit
            end
            DATA: begin
                if (bit_count < 4'b1000) begin
                    bit_count <= bit_count + 1; // Count data bits
                end else begin
                    next_state = STOP; // Move to stop state after 8 bits
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done = 1'b1; // Signal done
                    next_state = IDLE; // Go back to idle
                end else begin
                    // Stay in STOP until stop bit is detected
                end
            end
        endcase
    end
endmodule