module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        START = 3'b001,
        DATA  = 3'b010,
        STOP  = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count; // To count the 8 data bits
    logic [7:0] data_reg;  // Shift register for data bits

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 4'd0;
            data_reg <= 8'd0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold state
        done = 1'b0; // Default done signal

        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end

            START: begin
                next_state = DATA;
                bit_count = 4'd0; // Reset bit counter
            end

            DATA: begin
                if (bit_count == 4'd8) // All 8 data bits received
                    next_state = STOP;
                else
                    next_state = DATA;
            end

            STOP: begin
                if (in == 1'b1) begin // Correct stop bit
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end

            ERROR: begin
                if (in == 1'b1) // Wait for stop bit to return to IDLE
                    next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // Data capture logic
    always_ff @(posedge clk) begin
        if (current_state == DATA) begin
            data_reg <= {in, data_reg[7:1]}; // Shift in data bits
            bit_count <= bit_count + 1;
        end
    end

endmodule