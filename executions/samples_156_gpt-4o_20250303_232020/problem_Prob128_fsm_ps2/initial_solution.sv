module TopModule(
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE_1_RECEIVED = 2'b01,
        BYTE_2_RECEIVED = 2'b10,
        BYTE_3_RECEIVED = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE_2_RECEIVED && next_state == BYTE_3_RECEIVED) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1_RECEIVED;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE_1_RECEIVED: begin
                next_state = BYTE_2_RECEIVED;
            end
            BYTE_2_RECEIVED: begin
                next_state = BYTE_3_RECEIVED;
            end
            BYTE_3_RECEIVED: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1_RECEIVED;
                end else begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule