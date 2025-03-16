module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] data_reg;

    // State transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            bit_count <= 3'b0;
            data_reg <= 8'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0) begin // Detect start bit
                        next_state <= START;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                START: begin
                    if (in == 1'b0) begin // Confirm start bit
                        next_state <= DATA;
                        bit_count <= 3'b0;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                DATA: begin
                    data_reg[bit_count] <= in;
                    if (bit_count == 3'b111) begin
                        next_state <= STOP;
                    end else begin
                        bit_count <= bit_count + 1;
                        next_state <= DATA;
                    end
                end
                STOP: begin
                    if (in == 1'b1) begin // Detect stop bit
                        out_byte <= data_reg;
                        done <= 1'b1;
                        next_state <= IDLE;
                    end else begin
                        next_state <= ERROR;
                    end
                end
                ERROR: begin
                    if (in == 1'b1) begin // Wait for stop bit
                        next_state <= IDLE;
                    end else begin
                        next_state <= ERROR;
                    end
                end
                default: next_state <= IDLE;
            endcase
        end
    end

endmodule