module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
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
    logic [7:0] data_reg;
    logic [2:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            data_reg <= 8'b0;
            bit_count <= 3'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STOP && next_state == IDLE) begin
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
            DATA0, DATA1, DATA2, DATA3, DATA4, DATA5, DATA6, DATA7: begin
                data_reg[bit_count] = in;
                if (bit_count == 3'b111) begin
                    next_state = STOP;
                end else begin
                    next_state = current_state + 1;
                end
            end
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
        endcase
    end

    always_ff @(posedge clk) begin
        if (current_state == START || (current_state >= DATA0 && current_state <= DATA7)) begin
            bit_count <= bit_count + 1;
        end else begin
            bit_count <= 3'b0;
        end
    end

endmodule