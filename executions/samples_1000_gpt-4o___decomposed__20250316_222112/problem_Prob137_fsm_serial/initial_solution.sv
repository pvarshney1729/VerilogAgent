module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        START = 3'b001,
        DATA  = 3'b010,
        STOP  = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_counter;

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_counter <= bit_counter + 1;
            end else begin
                bit_counter <= 3'b000;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 3'b111) // 8 data bits received
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin // Detect stop bit
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) // Wait for line to return to idle
                    next_state = IDLE;
            end
        endcase
    end

endmodule