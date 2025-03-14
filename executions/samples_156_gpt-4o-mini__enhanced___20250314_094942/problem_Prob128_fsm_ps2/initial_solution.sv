module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVE_BYTE1,
        RECEIVE_BYTE2,
        RECEIVE_BYTE3
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE_BYTE3) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = RECEIVE_BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            RECEIVE_BYTE1: begin
                next_state = RECEIVE_BYTE2;
            end
            RECEIVE_BYTE2: begin
                next_state = RECEIVE_BYTE3;
            end
            RECEIVE_BYTE3: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule