[BEGIN]
module TopModule (
    input  logic clk,        // Clock signal, positive edge triggered
    input  logic reset,      // Active-high synchronous reset
    input  logic in,         // Serial input bit stream
    output logic done        // Output signal asserted when a byte is correctly received
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        START = 3'b001,
        DATA  = 3'b010,
        STOP  = 3'b011,
        DONE  = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_counter;  // Counter for 8 data bits
    logic [7:0] data_reg;     // Shift register for data bits

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
            data_reg <= 8'b00000000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0) begin  // Detect start bit
                        next_state <= START;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                START: begin
                    next_state <= DATA;
                    bit_counter <= 3'b000; // Reset bit counter when starting data reception
                end
                DATA: begin
                    data_reg <= {in, data_reg[7:1]};  // Shift in data bit
                    if (bit_counter == 3'b111) begin
                        next_state <= STOP;
                    end else begin
                        bit_counter <= bit_counter + 1'b1;
                        next_state <= DATA;
                    end
                end
                STOP: begin
                    if (in == 1'b1) begin  // Detect stop bit
                        next_state <= DONE;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                DONE: begin
                    done <= 1'b1;
                    next_state <= IDLE;
                end
                default: next_state <= IDLE;
            endcase
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
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 3'b111) begin
                    next_state = STOP;
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
            default: next_state = IDLE;
        endcase
    end

endmodule
[Done]