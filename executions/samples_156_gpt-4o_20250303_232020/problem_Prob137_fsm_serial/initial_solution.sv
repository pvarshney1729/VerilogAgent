module TopModule (
    input logic clk,          // Clock signal, positive-edge triggered
    input logic reset,        // Active-high synchronous reset
    input logic in,           // Serial data input
    output logic done         // Output signal indicating a byte has been correctly received
);

    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        START = 3'b001,
        DATA0 = 3'b010,
        DATA1 = 3'b011,
        DATA2 = 3'b100,
        DATA3 = 3'b101,
        DATA4 = 3'b110,
        DATA5 = 3'b111,
        DATA6 = 3'b000,
        DATA7 = 3'b001,
        STOP  = 3'b010,
        ERROR = 3'b011
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] data_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            bit_count <= 3'b000;
            data_reg <= 8'b00000000;
        end else begin
            current_state <= next_state;
            if (current_state >= DATA0 && current_state <= DATA7) begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
            end
            if (current_state == STOP && in == 1'b1) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA0;
            end
            DATA0: next_state = DATA1;
            DATA1: next_state = DATA2;
            DATA2: next_state = DATA3;
            DATA3: next_state = DATA4;
            DATA4: next_state = DATA5;
            DATA5: next_state = DATA6;
            DATA6: next_state = DATA7;
            DATA7: next_state = STOP;
            STOP: begin
                if (in == 1'b1) begin
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
            default: next_state = IDLE;
        endcase
    end

endmodule