module TopModule(
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] message_reg;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            message_reg <= 24'b0;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE1) begin
                message_reg[23:16] <= in;
            end else if (current_state == BYTE2) begin
                message_reg[15:8] <= in;
            end else if (current_state == BYTE3) begin
                message_reg[7:0] <= in;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        done = (current_state == BYTE3);
        if (done) begin
            out_bytes = message_reg;
        end else begin
            out_bytes = 24'bx;
        end
    end

endmodule