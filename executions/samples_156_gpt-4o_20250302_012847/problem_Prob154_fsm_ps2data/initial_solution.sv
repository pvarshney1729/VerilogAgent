module byte_capture (
    input logic clk,
    input logic reset,
    input logic [7:0] byte_in,
    input logic capture,
    output logic [23:0] data_out,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] data_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            data_reg <= 24'b0;
        end else begin
            current_state <= next_state;
            if (capture) begin
                case (current_state)
                    BYTE1: data_reg[23:16] <= byte_in;
                    BYTE2: data_reg[15:8] <= byte_in;
                    BYTE3: data_reg[7:0] <= byte_in;
                endcase
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        done = 1'b0;
        case (current_state)
            IDLE: if (capture) next_state = BYTE1;
            BYTE1: if (capture) next_state = BYTE2;
            BYTE2: if (capture) next_state = BYTE3;
            BYTE3: begin
                if (capture) begin
                    next_state = IDLE;
                    done = 1'b1;
                end
            end
        endcase
    end

    // Output logic
    always @(*) begin
        data_out = data_reg;
    end

endmodule