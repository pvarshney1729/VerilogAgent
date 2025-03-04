```verilog
module TopModule (
    input logic clk,           // Clock input, positive edge-triggered
    input logic reset,         // Active-high synchronous reset
    input logic in,            // Serial data input, 1-bit
    output logic done          // Output signal, active high when a byte is successfully received
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA_RECEIVE = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] data_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            data_reg <= 8'b00000000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        done = 1'b0;

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
                    next_state = STOP;
                end
            end

            STOP: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end

            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Data reception logic
    always_ff @(posedge clk) begin
        if (current_state == DATA_RECEIVE) begin
            data_reg <= {in, data_reg[7:1]};
            bit_count <= bit_count + 1;
        end else begin
            bit_count <= 3'b000;
        end
    end

endmodule
```