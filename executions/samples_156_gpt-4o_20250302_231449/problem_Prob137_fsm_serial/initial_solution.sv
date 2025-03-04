module TopModule (
    input  logic clk,        // Clock input, positive edge triggered
    input  logic reset,      // Active-high synchronous reset
    input  logic in,         // Serial data input, 1-bit
    output logic done        // Output signal indicating a byte has been correctly received
);

    typedef enum logic [3:0] {
        IDLE  = 4'b0000,
        START = 4'b0001,
        DATA0 = 4'b0010,
        DATA1 = 4'b0011,
        DATA2 = 4'b0100,
        DATA3 = 4'b0101,
        DATA4 = 4'b0110,
        DATA5 = 4'b0111,
        DATA6 = 4'b1000,
        DATA7 = 4'b1001,
        STOP  = 4'b1010
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data_byte;
    logic [2:0] bit_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            data_byte <= 8'b0;
            bit_counter <= 3'b0;
        end else begin
            current_state <= next_state;
        end
    end

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
                next_state = DATA0;
            end
            DATA0: begin
                data_byte[0] = in;
                next_state = DATA1;
            end
            DATA1: begin
                data_byte[1] = in;
                next_state = DATA2;
            end
            DATA2: begin
                data_byte[2] = in;
                next_state = DATA3;
            end
            DATA3: begin
                data_byte[3] = in;
                next_state = DATA4;
            end
            DATA4: begin
                data_byte[4] = in;
                next_state = DATA5;
            end
            DATA5: begin
                data_byte[5] = in;
                next_state = DATA6;
            end
            DATA6: begin
                data_byte[6] = in;
                next_state = DATA7;
            end
            DATA7: begin
                data_byte[7] = in;
                next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule